require 'db_tasks'
require 'rails'

module DbTasks
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'db_tasks/railties/tasks.rake'
    end
  end
end
