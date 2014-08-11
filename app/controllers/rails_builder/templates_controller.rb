module RailsBuilder
  class TemplatesController < ApplicationController
    def index
      path = "/Users/kadrm002/Sites/rails_builder/spec/dummy/app/views/home/index.html.erb"
      data = JSON.parse '{"id":"","classNames":"btn btn-large btn-home","tagName":"a", "text": "Not sure what you''re looking for?<br>Click here to browse all research opportunities"}'
      
      parse_erb_file(path, data)
    end

    private
      def parse_erb_file(path, data)
        #erb = ERB.new(File.read(path))
        erb = IO.read(path)
        #erb_elements = erb.match(/<%=(.*)%>/)[2]
        erb_elements = erb.to_enum(:scan, /<%=(.*)%>/).map { Regexp.last_match[0] }
        #erb_elements = erb.scan(/regex/).flatten
        match_tag(data)
      end

      def match_tag(data)
        raise data.to_yaml
        case data
        when "A"
          puts 'Well done!'
        when "B"
          puts 'Try harder!'
        when "C"
          puts 'You need help!!!'
        end
      end
  end
end