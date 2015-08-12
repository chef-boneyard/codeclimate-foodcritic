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
        linter = FoodCritic::Linter.new()
        lints = linter.check({ "cookbook_paths" => @code,
                               "progress" => true,
                               "exclude_paths" => exclude_paths}).warnings
        lints.each do |lint|
          lint_hash = { 
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
  
          puts "#{lint_hash.to_json}\0"
        end
      end

      private

      def exclude_paths
        (config = @config["config"]) ? config["excludes"] : []
      end

    end
  end
end
