# Command is the main point of entry for git_cloud commands; shell arguments are
# passd through to Command, which then filters and parses through indivdual
# commands and reroutes them to constituent object classes.

require 'bitly'

module GitCloud
  class Command
    class << self

      CONFIG_FILE = "#{ENV['HOME']}/.git_cloud.cfg"

      # Public: executes a command.
      #
      # args    - The arguments passed in. Should only be one (the file_path) so
      #           displays the help if greater.
      def execute(*args)

        return help unless args.size > 0
        return help if args[0] == 45 # any - dash options are pleads for help

        begin
          upload!(args[0])
          begin
            final_url = bitly.shorten(url).short_url
          rescue # Bitly failue - just use git url
            final_url = url
          end
          output Clipboard.copy(final_url)
        rescue GitCloud::GitException => ge
          output ge.message
          output "     Are you sure git is installed and you have configured your"
          output "     repository."
        rescue GitCloud::FileException => fe
          output fe.message
        end
      end

      private

      # Private: git for the git_cloud's repo
      #
      # Returns a Git instance.
      def git
        @git ||= GitCloud.git(config)
      end

      # Public: uploads the File to the cloud
      #
      # file_path - String file_path to push to the cloud
      #
      # Returns true if file is uploaded to the cloud or false
      def upload!(file_path)
        git.upload!(file_path)
      end

      # Public: get the url for the pushed file path
      #
      # Returns the String url of the pushed file path
      def url
        git.url
      end

      # Private: prints any given string.
      #
      # s = String output
      #
      # Prints to STDOUT and returns. This method exists to standardize output
      # and for easy mocking or overriding.
      def output(s)
        puts(s)
      end

      # Private: prints all the commands of git_cloud.
      #
      # Returns nothing.
      def help
        text = %{
          - git_cloud: help ----------------------------------------------

          git_cloud                       this help text
          git_cloud <file_path>           copy file_path to the cloud and
                                        return its url
          git_cloud help                  this help text

          all other documentation is located at:
            https://github.com/wmernagh/git_cloud

        }.gsub(/^ {8}/, '') # strip the first eight spaces of every line

        output text
      end

      # Private: prints configuration details.
      #
      # Returns nothing.
      def config_howto
        text = %{
          - git_cloud: not configured ------------------------------------

          You need to add the following to your ~/.git_cloud.cfg file

          GIT_UPSTREAM   = "https://github.com/johndoe/gh_cloud"
          GIT_REPO_ROOT  = "~/.gh_cloud"
          FOLDER_LAYOUT  = "%Y/%B"
          BITLY_USERNAME = "johndoe"
          BITLY_API_KEY  = "XXXXX"

          more documentation is located at:
            https://github.com/wmernagh/git_cloud

        }.gsub(/^ {8}/, '') # strip the first eight spaces of every line

        output text
      end

      # Private: returns the configuration details.
      #
      # Returns ParseConfig.
      def config
        unless File.exist?(CONFIG_FILE)
          config_howto
          exit!(1)
        end

        ParseConfig.new(CONFIG_FILE)
      end

      # Private: bit.ly API instance created with the username and API_KEY
      # defined in the config file
      #
      # Example
      #   BITLY_API_KEY  = "B900398109128301293"
      #   BITLY_USERNAME = "jdoe"
      #
      # Returns a bit.ly API instance
      def bitly
        Bitly.use_api_version_3
        @bitly || Bitly.new(
          config.get_value('BITLY_USERNAME'),config.get_value('BITLY_API_KEY'))
      end
    end
  end
end
