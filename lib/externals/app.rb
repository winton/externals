module Externals
  class App
    
    def initialize(base_dir)
      @base_dir = base_dir
    end
    
    def config
      return @config if @config
      config_path = ['config/externals.yml', '.externals.yml'].detect do |file|
        File.exists? File.expand_path(@base_dir + '/' + file)
      end
      @config = YamlConfig.new(@base_dir, config_path)
    end

    def freeze(filter = nil)
      config.each_repo(filter) { |r| r.freeze }
    end

    def run(action, filter_str = nil)
      available_actions = %w(st status fr freeze un unfreeze)
      if available_actions.include?(action)
        filter = Regexp.new(filter_str) if filter_str
        send(action, filter)
      else
        puts "Usage: externals (#{available_actions.join(':')}) optional_regex_string"
      end
    end
    
    def status(filter = nil)
      config.each_repo(filter) { |r| r.status }
    end
    
    def unfreeze(filter = nil)
      config.each_repo(filter) { |r| r.unfreeze }
    end
    
    alias_method :fr, :freeze
    alias_method :st, :status
    alias_method :un, :unfreeze
  end
end
