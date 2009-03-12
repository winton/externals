module Externals
  class App
    def initialize(base_dir)
      @base_dir = base_dir
    end

    def status
      config.each_repo {|r| r.status }
    end

    def freeze
      config.each_repo {|r| r.freeze }
    end

    def unfreeze
      config.each_repo {|r| r.unfreeze }
    end

    def run(action)
      available_actions = %w(status freeze unfreeze)
      if available_actions.include?(action)
        send(action)
      else
        puts "Usage: externals (#{available_actions.join(':')})"
      end
    end

    def config
      return @config if @config

      config_file = ['config/externals.yml', '.externals.yml'].detect do |file|
        File.file? File.expand_path(@base_dir + '/' + file)
      end

      if config_file.nil?
        $stderr.puts "config/externals.yml is missing"
      else
        @config = YamlConfig.new(@base_dir, File.read(config_file))
      end
    end
  end
end
