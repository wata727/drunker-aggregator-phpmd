module Drunker
  class Aggregator
    class Phpmd < Base
      def run(layers)
        pmd = REXML::Element.new("pmd")
        pmd.add_attribute("version", "@project.version@")
        pmd.add_attribute("timestamp", Time.now.iso8601)

        layers.each do |layer|
          if layer.invalid?
            STDERR.puts "ERROR: Invalid layer. build_id=#{layer.build_id}"
          else
            begin
              doc = REXML::Document.new(layer.stdout)

              doc.elements.each("pmd/file") do |file|
                pmd.add_element(file)
              end
            rescue REXML::ParseException => exn
              STDERR.puts "ERROR: XML parse error occurred. "
                            + "build_id=#{layer.build_id}, "
                            + "stdout=#{layer.stdout}, "
                            + "stderr=#{layer.stderr}, "
                            + "exit_status=#{layer.exit_status}, "
                            + "exception=#{exn.inspect}"
            end
          end
        end

        doc = REXML::Document.new
        doc << REXML::XMLDecl.new("1.0", "UTF-8")
        doc.context[:attribute_quote] = :double_quote
        doc.add_element(pmd)
        result = StringIO.new
        REXML::Formatters::Pretty.new.write(doc, result)
        puts result.string
      end

      def exit_status(layers)
        layers.map { |layer| layer.invalid? ? 1 : layer.exit_status }.max
      end
    end
  end
end
