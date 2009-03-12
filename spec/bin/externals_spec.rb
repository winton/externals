require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe :externals do
  before(:all) do
    @stdout = $stdout
    $stdout = StringIO.new
    # Test $stdout.string
  end
  
  after(:all) do
    $stdout = @stdout
  end
  
  describe "help" do
    it "should show a help message with no input" do
      run
      $stdout.string.should match(/Usage: externals/)
    end
  end
  
  describe "status" do
    it "should tell the user if the repository exists" do
    end
    
    it "should tell the user if the repository is frozen" do
    end
    
    it "should tell the user if a snapshot exists" do
    end
  end
  
  describe "freeze" do
    describe "on a non-existent repository" do
      it "should clone a new repository" do
      end
    end
    
    describe "on a frozen repository" do
      it "should tell the user the repository is already frozen" do
      end
    end
    
    describe "on an unfrozen repository" do
      it "should make the temp directory if it does not exist" do
      end
    
      it "should compress the repository's .git folder to the temp directory" do
      end
    
      it "should remove the repository's .git folder" do
      end
    
      describe "when a snapshot exists" do
        it "should ask the user if the user wants to overwrite the snapshot" do
        end
      
        it "should not overwrite if the user says no" do
        end
      end
    end
  end
  
  describe "unfreeze" do
    describe "on a frozen repository" do
      it "should tell the user the repository is already unfrozen" do
      end
    end
    
    describe "on a non-existent repository" do
      it "should clone the repository" do
      end
    end
    
    describe "on a frozen repository" do
      describe "that has a snapshot" do
        it "should decompress the snapshot" do
        end
        
        it "should move the snapshot back to the repository" do
        end
        
        it "should remove the snapshot" do
        end
        
        it "should reset the repository" do
        end
      end
      
      describe "that does not have a snapshot" do
        it "should clone a new repository" do
        end
      end
    end
  end
  
  def run(action=nil)
    app = Externals::App.new(FileUtils.pwd)
    app.run(action)
  end
end