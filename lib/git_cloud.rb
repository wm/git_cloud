begin
  require 'rubygems'
rescue LoadError
end

require 'fileutils'
require 'parseconfig'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'git_cloud/clipboard'
require 'git_cloud/command'
require 'git_cloud/git'
require 'git_cloud/git_exception'
require 'git_cloud/file_exception'

module GitCloud
  VERSION = '0.0.2'

  # Public: returns an instance of Git
  #
  # config - ParseConfig configuration options
  #
  # Returns nothing.
  def self.git(config)
    @git ||= GitCloud::Git.new(config)
  end

  # Public: stores the path of the file as its fully extended path
  #
  # path - String path to the file or folder to push to the cloud
  #
  # Returns the String fully extended path of the file/folder
  def self.file(path)
    @file ||= GitCloud::File.new(path)
  end
end
