module Chow
  class Datafix
    SUCCESS = :success
    FAILED = :failed
    IN_PROGRESS = :in_progress

    FailedError = Class.new(Exception)

    attr_accessor :source, :sandbox, :config
    attr_reader :queries, :name

    def initialize(name, queries=Chow::Queries.new)
      @name = name
      @queries = queries
      @conn = Chow::Conn
    end

    def run
      unless skip?
        begin
          source.call(self)
          queries.insert(name, Chow::Datafix::SUCCESS)
        rescue Exception => e
          queries.insert(name, Chow::Datafix::FAILED)
          raise Chow::Datafix::FailedError, e
        end
      end
    end

    private

    def already_ran?(status)
      queries.find(self.name, status)
    end

    def skip?
      sandbox || already_ran?(Chow::Datafix::SUCCESS)
    end

  end
end