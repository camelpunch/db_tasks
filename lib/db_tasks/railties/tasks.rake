namespace :db do
  desc "Import production database to current environment"
  task :import_production => :environment do
    config = YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))
    source = config['production']
    dest = config[Rails.env]

    %w(ssh_username ssh_host).each do |key|
      if source[key].blank?
        raise "Missing #{key} key in production stanza of config/database.yml"
      end
    end

    command = "ssh #{source['ssh_username']}@#{source['ssh_host']} 'mysqldump -h #{source['host']} -u #{source['username']} -p#{source['password']} #{source['database']}' | mysql -h #{dest['host']} -u #{dest['username']} #{dest['database']}"
    `#{command}`
  end
end
