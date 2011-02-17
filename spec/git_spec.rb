require 'spec_helper'
require 'parseconfig'
require 'git_cloud'

describe GitCloud::Git do
  let(:pid)          { Process.pid }
  let(:config)       { mock('config') }
  let(:branch)       { "master" }
  let(:upstream)     { "https://github.com/johndoe/gh_cloud" }
  let(:repo)         { "/tmp/#{pid}_gh_cloud_test" }
  let(:valid_file)   { "/tmp/#{pid}_valid_file" }
  let(:valid_folder) { "/tmp/#{pid}_valid_folder" }
  let(:now)          { Time.now }

  before do
    system("touch #{valid_file}")
    system("mkdir #{valid_folder}")
    system("touch #{valid_folder}/a_file")
    system("mkdir #{repo};cd #{repo};git init")
    config.stubs(:get_value).with("GIT_REPO_ROOT").returns(repo)
    config.stubs(:get_value).with("FOLDER_LAYOUT").returns("%Y/%B")
    config.stubs(:get_value).with("GIT_UPSTREAM").returns(upstream)
    now
    Time.stubs(:now).returns(now)
  end

  describe "upload valid file!"do
    let(:git) { GitCloud::Git.new(config) }

    before do
      GitCloud::Command.stubs(:git).returns(git)
      git.stubs(:push).returns(true)
      git.upload!(valid_file).should == true
    end

    it "should create the folder to store todays files" do
      fpath = "#{repo}/#{now.strftime('%Y/%B')}"
      File.exists?(fpath).should == true
    end

    it "should copy the file to the repo" do
      fpath = "#{repo}/#{now.strftime('%Y/%B')}/#{File.basename(valid_file)}"
      File.exists?(fpath).should == true
    end

    it "should return the url to the file in the cloud" do
      upath ="#{upstream}/raw/master/#{Time.now.strftime("%Y/%B")}/#{File.basename(valid_file)}"
      git.url.should == upath
    end
  end

  describe "upload valid folder!"do
    let(:git) { GitCloud::Git.new(config) }

    before do
      GitCloud::Command.stubs(:git).returns(git)
      git.stubs(:push).returns(true)
      git.upload!(valid_folder).should == true
    end

    it "should create the folder to store todays files" do
      fpath = "#{repo}/#{now.strftime('%Y/%B')}"
      File.exists?(fpath).should == true
    end

    it "should copy the file to the repo" do
      fpath = "#{repo}/#{now.strftime('%Y/%B')}/#{File.basename(valid_folder)}"
      File.exists?(fpath).should == true
    end

    it "should return the url to the file in the cloud" do
      upath ="#{upstream}/tree/master/#{Time.now.strftime("%Y/%B")}/#{File.basename(valid_folder)}"
      git.url.should == upath
    end
  end

  after do
    system("rm -rf #{valid_file} #{valid_folder} #{repo}")
  end

end
