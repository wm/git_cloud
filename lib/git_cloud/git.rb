# Git is used to do the file copy, add, commit, push
#
module GitCloud
  class Git

    # Public: initializes a Git instance by loading in your persisted data.
    #
    # ParseConfig - The configuration options
    #
    # Returns nothing.
    def initialize(config = nil)
      @config = config
      @folder_name = Time.now.strftime(folder_layout)
      @folder_path = File.join(repo_path,folder_name)
      bootstrap_folder unless File.exist?(@folder_path)
    end

    # Public: uploads the File to the cloud
    #
    # file_path - String file_path to push to the cloud
    #
    # Raises FileNotFound Exception if file_path is invlaid
    # Raises GitException if it fails to add, commit, or push
    def upload!(file_path)
      raise GitCloud::FileException.new("NotFound") unless File.exists? file_path
      file = File.new(File.expand_path(file_path))
      add(file)
      commit
      push
    end

    # Public: get the url for the pushed file path
    #
    # Returns the String url of the pushed file path
    def url
      type = File.directory?(file) ? "tree" : "raw"
      name = file.path.split('/').last
      %{#{upstream}/#{type}/#{branch}/#{folder_name}/#{name}}
    end

    private
    # Private: the path to the git repo used by git_cloud.
    #
    # Returns the String path to git_cloud's git repo.
    def repo_path
      @config.get_value('GIT_REPO_ROOT')
    end

    # Private: the url of the upstream git repo used by git_cloud.
    #
    # Returns the String path to git_cloud's git repo.
    def upstream
      @config.get_value('GIT_UPSTREAM')
    end

    # Private: the branch the local machine is using
    #
    # Returns the String branch of git_cloud's git repo.
    def branch
      %x[cd #{repo_path};git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'}].chomp
    end

    # Private: copies the file_path contents to the repo and git-adds it
    #
    # file - the file path String
    #
    # Raises GitException if it fails to add
    def add(file)
      @file = file
      FileUtils.cp_r(file.path,folder_path)
      unless system("cd #{repo_path};git add .")
        raise GitCloud::GitException.new("Add")
      end
    end

    # Private: git-commits the repo_path
    #
    # Raises GitException if it fails to commit
    def commit
      system("cd #{repo_path};git commit -m 'to the cloud'")
    end

    # Private: git-pushes the repo_path
    #
    # Raises GitException if it fails to push
    def push
      unless system("cd #{repo_path};git push origin #{branch}")
        raise GitCloud::GitException.new("Push")
      end
    end

    # Private returns the file we are manipulating
    #
    # Return File
    def file
      @file
    end

    # Private: Takes care of bootstrapping the folder_path
    #
    # Return true if successfully create.
    def bootstrap_folder
      FileUtils.mkdir_p folder_path
    end

    # Private: returns the folder name where we will store the passed in path
    #
    # Returns the String folder_name
    def folder_layout
      @config.get_value('FOLDER_LAYOUT')
    end

    # Private: returns the folder name where we will store the passed in path
    #
    # Returns the String folder_name
    def folder_name
      @folder_name
    end

    # Private: the path to the folder in git_cloud to store new files.
    #
    # Returns the String path of the folder in git_cloud's git repo that new files
    # will be copied to.
    def folder_path
      File.expand_path @folder_path
    end

  end
end
