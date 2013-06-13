require 'rspec/autorun'
require 'chow'

class FakeConn
  def exec
  end
end

shared_context :datafix do
  let(:datafix) { Chow::Datafix.new("foo") }
  let(:klass) do
    Class.new do
      def self.foo
      end
    end
  end
end
Chow::Conn.connection = FakeConn.new


