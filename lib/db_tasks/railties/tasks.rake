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

    time = Time.now.strftime('%Y%m%d%H%M%S')
    base_dump_filename = "#{source['database']}_#{time}.sql"
    dump_filename = "#{base_dump_filename}.bz2"
    remote_ssh = "#{source['ssh_username']}@#{source['ssh_host']}"
    remote_db_opts = "-h #{source['host']} -u #{source['username']} -p#{source['password']} #{source['database']}"
    local_db_opts = "-h #{dest['host']} -u #{dest['username']} #{dest['database']}"

    command = "ssh #{remote_ssh} \
    'mysqldump #{remote_db_opts} | bzip2 > ~/#{dump_filename}' &&\
    scp #{remote_ssh}:#{dump_filename} db/#{dump_filename} &&\
    bunzip2 db/#{dump_filename} &&\
    mysql #{local_db_opts} < db/#{base_dump_filename}"

    `#{command}`
  end
end
