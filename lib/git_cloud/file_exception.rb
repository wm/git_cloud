module GitCloud
  class FileException < RuntimeError
    attr_reader :command, :message
    def initialize(cause)
      @cause = cause
      @message = "Error::FileException::#{@cause}"
    end
  end
end
