require 'yaml'

module Externals
  class YamlConfig
    
    attr_reader :repositories
    
    def initialize(base_dir, config_path)
      @base_dir = base_dir
      if config_path && File.exists?(config_path)
        config = YAML.load(File.read(config_path))
        @repositories = config.map do |name, attributes|
          Repository.new(
            @base_dir,
            name,
            attributes["repo"],
            attributes["path"]
          )
        end
      else
        $stderr.puts "config/externals.yml is missing"
        @repositories = []
      end
    end

    def each_repo(filter = nil)
      repositories.each do |r|
        if block_given? and (!filter or filter.match(r.name))
          yield(r)
        end
      end
    end
  end
end
