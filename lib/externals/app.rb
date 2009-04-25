module Externals
  class App
    def initialize(base_dir)
      @base_dir = base_dir
    end

    def status(filtr = nil)
      config.each_repo(filtr) {|r| r.status }
    end
    alias_method :st, :status

    def freeze(filtr = nil)
      config.each_repo(filtr) {|r| r.freeze }
    end

    def unfreeze(filtr = nil)
      config.each_repo(filtr) {|r| r.unfreeze }
    end

    def run(action, filtr_str = nil)
      available_actions = %w(status freeze unfreeze)
      if available_actions.include?(action)
        filtr = Regexp.new(filtr_str) if filtr_str
        send(action, filtr)
      else
        puts "Usage: externals (#{available_actions.join(':')}) optional_regex_string"
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
