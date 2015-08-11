require 'foodcritic'
require 'json'

module CC
  module Engine
    class Foodcritic
      def initialize(code, config, io)
        @code = code
        @config = config
        @io = io
      end

      def run
        linter = FoodCritic::Linter.new
        linter.check({"cookbook_paths" => @code, "progress" => true}).warnings.each do |lint|
          hash = { 
            "type" => "issue",
            "check_name" => "FoodCritic #{lint.rule.code}",
            "description" => lint.rule.name,
            "categories" => ["Style"],
            "location" => {
              "path" => lint.match[:filename].split("/code/")[1].to_s,
              "lines" => { 
                "begin" => lint.match[:line],
                "end" => lint.match[:line]
              }
            }
          }
  
          puts "#{hash.to_json}\0"
        end
      end

    end
  end
end
