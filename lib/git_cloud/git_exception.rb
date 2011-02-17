module GitCloud
  class GitException < RuntimeError
    attr_reader :command, :message
    def initialize(command)
      @command = command
      @message = "Error::GitException::#{@command}"
    end
  end
end
