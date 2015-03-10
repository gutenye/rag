class Rag
  module Util
    class ERB < ::ERB
      def result(bind=nil, locals={})
        bind ||= TOPLEVEL_BINDING
        if locals.empty?
          original_result bind
        else
          result_with_locals bind, locals
        end
      end

    private
      def result_with_locals(bind, locals)
        @locals = locals
        evalstr = <<-EOF
    def run_erb
      #{locals.map{|k,v| %~#{k} = @locals[ #{Symbol===k ? ':' : ''}'#{k}' ]~}.join(';')}
      #{self.src}
      _erbout
    end
        EOF
        eval evalstr
        run_erb
      end
    end
  end
end
