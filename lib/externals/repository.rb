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
      puts "#{@name} unfrozen"
      true
    end

    def freezify
      install unless File.exist?(repo_path)
      if frozen?
        puts "#{@name} is already frozen"
      elsif can_be_frozen?
        Dir.chdir(repo_path) do
          `rm #{temp_path}/#{@name}.git.tgz` if can_be_unfrozen?
          `mkdir -p #{temp_path}`
          `tar czf #{temp_path}/#{@name}.git.tgz .git`
          FileUtils.rm_r('.git')
        end
        puts "#{@name} frozen"
      else
        install
        freezify
      end
      true
    end
    
    def status
      puts "#{@name} is #{can_be_frozen? ? "not frozen" : "frozen"}"
    end

    def unfreezify
      install unless File.exist?(repo_path)
      if unfrozen?
        puts "#{@name} is already unfrozen"
      elsif can_be_unfrozen?
        Dir.chdir(temp_path) do
          `tar xzf #{@name}.git.tgz`
          FileUtils.mv(".git", repo_path)
          FileUtils.rm("#{@name}.git.tgz")
        end
        Dir.chdir(repo_path) do
          `git reset --hard`
        end
        puts "#{@name} unfrozen"
      else
        install
      end
      true
    end
    
    def can_be_frozen?
      File.exist?("#{repo_path}/.git")
    end
    
    def can_be_unfrozen?
      File.exists?("#{temp_path}/#{@name}.git.tgz")
    end

    def frozen?
      !File.exist?("#{repo_path}/.git") &&
      File.exists?("#{temp_path}/#{@name}.git.tgz")
    end
    
    def unfrozen?
      File.exist?("#{repo_path}/.git") &&
      !File.exists?("#{temp_path}/#{@name}.git.tgz")
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
