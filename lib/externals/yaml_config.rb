require 'yaml'

module Externals
  class YamlConfig
    def initialize(base_dir, yaml_string)
      @base_dir = base_dir
      @config_hash = YAML.load yaml_string
    end

    def each_repo(filtr = nil)
      repositories.each { |r| yield(r) if block_given? and (!filtr or filtr.match(r.name)) }
    end

    private
    def repositories
      @config_hash.map do |name, attributes|
        Repository.new(@base_dir, name, attributes["repo"], attributes["path"])
      end
    end
  end
end
