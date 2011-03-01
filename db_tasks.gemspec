Gem::Specification.new do |gem|
  gem.name = 'db_tasks'
  gem.version = File.read('VERSION')

  gem.authors = ["Andrew Bruce"]
  gem.date = Date.today.to_s
  gem.description = File.read('README.rdoc')
  gem.email = 'andrew@camelpunch.com'
  gem.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  gem.files = Dir[
    ".document",
    ".gitignore",
    "LICENSE",
    "README.rdoc",
    "VERSION",
    "lib/**/*",
  ]
  gem.homepage = 'http://github.com/camelpunch/db_tasks'
  gem.rdoc_options = ["--charset=UTF-8"]
  gem.require_paths = ["lib"]
  gem.summary = 'Various database tasks for Rails / MySQL'
end

