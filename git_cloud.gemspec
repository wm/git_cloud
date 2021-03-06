## This is the rakegem gemspec template. Make sure you read and understand
## all of the comments. Some sections require modification, and others can
## be deleted if you don't need them. Once you understand the contents of
## this file, feel free to delete any comments that begin with two hash marks.
## You can find comprehensive Gem::Specification documentation, at
## http://docs.rubygems.org/read/chapter/20
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'git_cloud'
  s.version           = '0.0.2'
  s.date              = '2011-02-16'
  s.rubyforge_project = 'git_cloud'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "git_cloud uploads a file to a github repo returning a short url link"
  s.description = "Send a file to your dedicated public github repo and have a short url  returned that points to the uploaded file"

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Will Mernagh"]
  s.email    = 'will.offers@gmail.com'
  s.homepage = 'https://github.com/wmernagh/git_cloud'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  ## This sections is only necessary if you have C extensions.
  #s.require_paths << 'ext'
  #s.extensions = %w[ext/extconf.rb]

  ## If your gem includes any executables, list them here.
  s.executables = ["git_cloud"]
  s.default_executable = 'git_cloud'

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[readme.markdown license.markdown]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  s.add_dependency('bitly', "~> 0.6.1")
  s.add_dependency('parseconfig', "~> 0.5.2")

  ## List your development dependencies here. Development dependencies are
  ## those that are only needed during development
  s.add_development_dependency('mocha', "~> 0.9.9")
  s.add_development_dependency('rspec', "~> 2.4.0")

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    CHANGELOG.markdown
    Gemfile
    Gemfile.lock
    LICENSE.markdown
    README.markdown
    Rakefile
    bin/git_cloud
    git_cloud.gemspec
    lib/git_cloud.rb
    lib/git_cloud/clipboard.rb
    lib/git_cloud/command.rb
    lib/git_cloud/file_exception.rb
    lib/git_cloud/git.rb
    lib/git_cloud/git_exception.rb
    spec/command_spec.rb
    spec/git_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  #s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
