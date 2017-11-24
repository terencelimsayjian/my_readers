if Rails.env.development? || Rails.env.test? || Rails.env.staging?

  namespace :dev do
    desc 'Sample data for local development'
    task prime: :environment do
      execute = proc do |seed|
        seed_path = Rails.root.join('db', 'seeds', "#{seed}.rb")
        if File.file?(seed_path)
          print "Seeding #{seed} ..."
          require seed_path
          puts 'Done!'
        end
      end

      %w[admins facilitators].each(&execute)
    end
  end

end
