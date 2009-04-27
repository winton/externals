require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module Externals
  describe Externals::YamlConfig do
    
    before(:each) do
      @rspec = mock("rspec")
      @foo = mock("foo")
      @rspec.stub!(:name).and_return('rspec')
      @foo.stub!(:name).and_return('foo')
      File.stub!(:read).and_return(
        "rspec:\n  repo: git://rspec\n  path: vendor/plugins\n" +
        "foo:\n  repo: git://at/foo\n  path: path/to/foo\n"
      )
      Repository.stub!(:new).and_return(@rspec)
      Repository.stub!(:new).and_return(@foo)
    end
    
    it "should create repositories" do
      File.stub!(:exists?).and_return(true)
      Repository.should_receive(:new).with(
        "base_dir", "rspec", "git://rspec", "vendor/plugins"
      )
      Repository.should_receive(:new).with(
        "base_dir", "foo", "git://at/foo", "path/to/foo"
      )
      config = YamlConfig.new("base_dir", "config/externals.yml")
    end
    
    it "should allow repository iteration" do
      File.stub!(:exists?).and_return(true)
      config = YamlConfig.new("base_dir", "config/externals.yml")
      config.each_repo { |r| [ @rspec, @foo ].include?(r).should == true }
      config.each_repo('r') { |r| r.should == @rspec }
      config.each_repo('f') { |r| r.should == @foo }
    end
    
    it "should error if config doesn't exist" do
      File.stub!(:exists?).and_return(false)
      $stderr.should_receive(:puts)
      config = YamlConfig.new('base_dir', 'config/externals.yml')
    end
  end
end