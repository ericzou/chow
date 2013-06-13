require 'spec_helper'
require 'pry'

describe 'Datafix run' do
  include_context :datafix

  before do
    datafix.source = Proc.new{ klass.foo() }
  end

  it "runs source" do
    klass.should_receive(:foo)
    datafix.run()
  end

  it 'does not run if skip?' do
    datafix.stub(:skip?).and_return(true)
    klass.should_receive(:foo).never
    datafix.run()
  end

end

describe 'Datafix queries' do
  include_context :datafix

  it 'saves a record on success run' do
    datafix.queries.should_receive(:insert).with(datafix.name, Chow::Datafix::SUCCESS)
    datafix.source = Proc.new{ klass.foo() }
    datafix.run()
  end

  it 'saves a record on failed run' do
    datafix.queries.should_receive(:insert).with(datafix.name, Chow::Datafix::FAILED)
    datafix.source = Proc.new{ raise "error" }
    expect{datafix.run()}.to raise_error
  end
end

describe 'Datefix skip?' do
  include_context :datafix

  it 'returns true if sandboxed' do
    datafix.sandbox = true
    expect(datafix.send(:skip?)).to eq(true)
  end

  it 'does not run if already ran successfully' do
    datafix.stub(:already_ran?).with(:success).and_return(true)
    expect(datafix.send(:skip?)).to eq(true)
  end
end