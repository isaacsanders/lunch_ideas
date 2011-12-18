require 'data_mapper'
require_relative './config'
Dir.glob('./app/**/*.rb').each do |file|
  require file
end

namespace :db do
  task :migrate do
    DataMapper.auto_migrate!
  end

  task :update do
    DataMapper.auto_upgrade!
  end
end
