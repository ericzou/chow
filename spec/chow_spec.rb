require 'spec_helper'

describe 'Chow configuration' do
  describe 'table name' do
    it 'defaults to :datafixes' do
      expect(Chow.table_name).to eq("datafixes")
    end

    it 'can config table name' do
      Chow.table_name = 'foo'
      expect(Chow.table_name).to eq("foo")
    end

  end

end

