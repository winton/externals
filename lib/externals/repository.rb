require 'fileutils'

module Externals
  class Repository
    
    def initialize(base_dir, name, repo_url, rel_path)
      @base_dir = base_dir
      @name = name
      @repo_url = repo_url
      @rel_path = rel_path
    end
    
    def install
      FileUtils.mkdir_p checkout_path unless File.exist?(checkout_path)
      `cd #{checkout_path} && rm -Rf #{@name} && git clone #{@repo_url} #{@name}`
      true
    end

    def freezify
      return true if frozen?
      Dir.chdir(repo_path) do
        `tar czf #{temp_path}/#{@name}.git.tgz .git`
        FileUtils.rm_r('.git')
      end
      true
    end

    def unfreezify
      return true unless frozen?
      Dir.chdir(temp_path) do
        `tar xzf #{@name}.git.tgz`
        FileUtils.mv(".git", repo_path)
        FileUtils.rm("#{@name}.git.tgz")
      end
      true
    end

    def frozen?
      File.exist?(repo_path) && !File.exist?("#{repo_path}/.git")
    end

    private
    def checkout_path
      File.expand_path(File.join(@base_dir, @rel_path))
    end

    def repo_path
      File.expand_path(checkout_path + '/' + @name)
    end

    def rel_repo_path
      @rel_path + '/' + @name
    end
    
    def temp_path
      @base_dir + '/tmp'
    end
  end
end
