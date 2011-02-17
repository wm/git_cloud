require 'spec_helper'
require 'parseconfig'
require 'git_cloud'

# Intercept STDOUT and collect it
class GitCloud::Command

  def self.capture_output
    @output = ''
  end

  def self.captured_output
    @output
  end

  def self.output(s)
    @output << s
  end

end

def command(cmd)
  cmd = cmd.split(' ') if cmd
  GitCloud::Command.capture_output
  GitCloud::Command.execute(*cmd)
  GitCloud::Command.captured_output
end

describe GitCloud::Command do
  let(:url) { "ddd" }
  let(:valid_file) { "/tmp/valid_file" }
  let(:invalid_file) { "/tmp/invalid_file" }
  let(:git) { nil }

  before do
    git.stub!(:upload!).with(valid_file).and_return(true)
    git.stub!(:url).and_return(url)
    GitCloud.stubs(:git).returns(git)
  end

  describe "upload valid file!"do
    it "should return the url to the file in the cloud" do
      command(valid_file).should == "Copied #{url} to your clipboard."
    end
  end

end
