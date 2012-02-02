class Rag
  class UI
    def warn(message)
    end

    def debug(message)
    end

    def error(message)
    end

    def info(message)
    end

    def confirm(message)
    end

    # delegate to info
    def say(message)
      info(message)
    end

    class Shell < UI
      attr_accessor :shell

      def initialize(shell)
        @shell = shell
        @quiet = false
        @debug = ENV['DEBUG']
      end

      def be_quiet!
        @quiet = true
      end

      def debug!
        @debug = true
      end

      def debug(msg)
        @shell.say(msg) if @debug && !@quiet
      end

      def info(msg)
        @shell.say(msg) if !@quiet
      end

      def confirm(msg)
        @shell.say(msg, :green) if !@quiet
      end

      def warn(msg)
        @shell.say(msg, :yellow)
      end

      def error(msg)
        @shell.say(msg, :red)
      end
    end
  end
end
