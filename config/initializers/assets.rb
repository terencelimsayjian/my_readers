Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Add name of controlelrs to array, and create a stylesheet nested in the folder of the same name
%w(static_pages).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}/#{controller}"]
end