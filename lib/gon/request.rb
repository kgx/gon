class Gon
  class Request
    def initialize(environment)
      @request_env = environment
      @gon = {}
    end

    def env
      @request_env if defined? @request_env
    end

    def id
      @request_id if defined? @request_id
    end

    alias_method :uuid, :id

    def id=(request_id)
      @request_id = request_id
    end

    alias_method :uuid=, :id=

    def gon
      @gon
    end

    def clear
      @gon = {}
    end

  end
end
