module Chow
  # Locator is used to locate the existing script
  class Queries

    # If found, the script has been ran,
    # not otherwise
    def find(name, status=:success)
      s = "SELECT * FROM #{Chow.table_name} WHERE name = $1 and status = $2"
      res = Conn.execute(s, name, status)
    end

    def insert(name, status)
      s = 'INSERT INTO #{Chow.table_name}(name, status, created_at, updated_at) VALUES ($1, $2, $3, $4)'
      res = Conn.execute(s, name, status, Time.now, Time.now)
    end

    def update(name, status)
      s = 'UPDATE #{Chow.table_name} SET status = $1 and updated_at = $2 WHERE name = $3'
      res = Conn.execute(s, status, Time.now, name)
    end

  end

end

