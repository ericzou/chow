module Chow
  autoload :Parser, 'chow/parser'
  autoload :Datafix, 'chow/datafix'
  autoload :Queries, 'chow/queries'
  autoload :Conn, 'chow/conn'

  def self.table_name
    @table_name ||= "datafixes"
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end
end