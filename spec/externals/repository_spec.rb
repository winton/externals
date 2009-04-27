require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module Externals
  describe Externals::Repository do
    
    before(:each) do
      @stdout = $stdout
      $stdout = StringIO.new
      @repo = Repository.new("/", "tmp", "git://", "/")
    end
    
    after(:each) do
      $stdout = @stdout
    end
    
    describe "freeze" do
      
      before(:each) do
        @repo.stub!(:exists?).and_return(false)
        @repo.stub!(:install)
        @repo.stub!(:is_not_a_git_repo?)
        @repo.stub!(:is_a_git_repo?).and_return(true)
        @repo.stub!(:is_compressed?).and_return(true)
        STDIN.stub!(:gets).and_return('y')
        FileUtils.stub!(:mkdir_p)
        FileUtils.stub!(:rm_r)
      end
      
      it "should install the repository if it does not exist" do
        @repo.should_receive(:install)
        @repo.freeze
      end
      
      it "should display a message if the repository is already frozen" do
        @repo.stub!(:is_not_a_git_repo?).and_return(true)
        @repo.freeze
        $stdout.string.include?("already frozen").should == true
      end
      
      it "should ask if the compressed file should be overwritten if exists" do
        @repo.stub!(:is_not_a_git_repo?).and_return(false)
        @repo.freeze
        $stdout.string.include?("Overwrite?").should == true
      end
      
      it "should remove the repository's .git file" do
        FileUtils.should_receive(:rm_r).with('.git')
        @repo.freeze
      end
    end
    
    describe "install" do
      
      before(:each) do
        File.stub!(:exist?)
        FileUtils.stub!(:mkdir_p)
        FileUtils.stub!(:rm_f)
      end
      
      after(:each) do
        @repo.install
      end
      
      it "should create the checkout path if does not exist" do
        File.should_receive(:exist?).and_return(false)
        FileUtils.should_receive(:mkdir_p)
      end
      
      it "should remove repository if exists" do
        FileUtils.should_receive(:rm_rf)
      end
    end
    
    describe "unfreeze" do
      
      before(:each) do
        @repo.stub!(:is_a_git_repo?)
        @repo.stub!(:exists?)
        @repo.stub!(:install)
        @repo.stub!(:is_not_a_git_repo?)
        @repo.stub!(:is_compressed?)
        FileUtils.stub!(:mv)
        FileUtils.stub!(:rm_f)
      end
      
      it "should display a message if the repository is already unfrozen" do
        @repo.should_receive(:is_a_git_repo?).and_return(true)
        @repo.unfreeze
        $stdout.string.include?("already unfrozen").should == true
      end
      
      it "should install the repository if it does not exist" do
        @repo.should_receive(:exists?).and_return(false)
        @repo.should_receive(:install)
        @repo.unfreeze
      end
      
      it "should display a message after the install" do
        @repo.should_receive(:is_a_git_repo?).and_return(false)
        @repo.should_receive(:exists?).and_return(false)
        @repo.unfreeze
        $stdout.string.include?("unfrozen").should == true
      end
      
      it "should move the uncompressed .git directory back to the repo if compressed file exists" do
        @repo.should_receive(:is_a_git_repo?).and_return(false)
        @repo.should_receive(:exists?).and_return(true)
        @repo.should_receive(:is_not_a_git_repo?).and_return(true)
        @repo.should_receive(:is_compressed?).and_return(true)
        FileUtils.should_receive(:mv)
        @repo.unfreeze
      end
      
      it "should remove the snapshot if compressed file exists" do
        @repo.should_receive(:is_a_git_repo?).and_return(false)
        @repo.should_receive(:exists?).and_return(true)
        @repo.should_receive(:is_not_a_git_repo?).and_return(true)
        @repo.should_receive(:is_compressed?).and_return(true)
        FileUtils.should_receive(:rm_f)
        @repo.unfreeze
      end
      
      it "should install the repository if no snapshot found" do
        @repo.should_receive(:is_a_git_repo?).and_return(false)
        @repo.should_receive(:exists?).and_return(true)
        @repo.should_receive(:is_not_a_git_repo?).and_return(true)
        @repo.should_receive(:is_compressed?).and_return(false)
        @repo.should_receive(:install)
        @repo.unfreeze
      end
      
      it "should display a message when finished" do
        @repo.should_receive(:is_a_git_repo?).and_return(false)
        @repo.should_receive(:exists?).and_return(true)
        @repo.should_receive(:is_not_a_git_repo?).and_return(true)
        @repo.unfreeze
        $stdout.string.include?("unfrozen").should == true
      end
    end
  end
end