class Rag
  class UI
    class Shell < Base
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
