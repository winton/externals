module Externals
  class App
    def initialize(base_dir)
      @base_dir = base_dir
    end

    def install
      config.each_repo {|r| r.install }
    end

    def freezify
      config.each_repo {|r| r.freezify }
    end

    def unfreezify
      config.each_repo {|r| r.unfreezify }
    end

    def run(action)
      case action
      when "install"
        install
      when "freeze"
        freezify
      when "unfreeze"
        unfreezify
      end
    end

    def config
      return @config if @config

      config_file = ['config/externals.yml', '.externals.yml'].detect do |file|
        File.file? File.expand_path(@base_dir + '/' + file)
      end

      if config_file.nil?
        $stderr.puts "config/externals.yml is missing"
        exit 1
      end

      @config = YamlConfig.new(@base_dir, File.read(config_file))
    end
  end
end
