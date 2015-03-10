class Thor
  module Actions
    def directory2(source, *args, &block)
      config = args.last.is_a?(Hash) ? args.pop : {}
      destination = args.first || source
      action Directory2.new(self, source, destination || source, config, &block)
    end

    # use tilt
    # :scope => nil
    # :locals => {}
    # &block is  for yield.
    def template2(source, *args, &block)
      config = args.last.is_a?(Hash) ? args.pop : {}
      destination = args.first || source.sub(/\.tt$/, '')
      template_options = {source_root: self.class.source_root}

      source = File.expand_path(find_in_source_paths(source.to_s))

      create_file destination, nil, config do
        Rag::Template.render(source, template_options, &block)
      end
    end

    class Directory2 < Directory #:nodoc:
      protected
        def execute!
          lookup = config[:recursive] ? File.join(source, '**') : source
          lookup = File.join(lookup, '{*,.[a-z]*}')

          Dir[lookup].sort.each do |file_source|
            next if File.directory?(file_source)
            file_destination = File.join(given_destination, file_source.gsub(source, '.'))
            file_destination.gsub!('/./', '/')

            case file_source
              when /\.empty_directory$/
                dirname = File.dirname(file_destination).gsub(/\/\.$/, '')
                next if dirname == given_destination
                base.empty_directory(dirname, config)
              when /\.tt$/
                destination = base.template2(file_source, file_destination[0..-4], config, &@block)
              else
                destination = base.copy_file(file_source, file_destination, config, &@block)
            end
          end
        end
    end
  end
end
