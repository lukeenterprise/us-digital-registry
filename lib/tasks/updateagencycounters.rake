require "logger"
namespace :agencies do
    desc "update agencies counters"
    task :updateagencycounters => :environment do
    
        logger = Logger.new(STDOUT)
        logger.debug('Program begin')
        agency.all.each do | agency |
            agency.update_counters
            agency.save
        end
      
        logger.debug('Program Completed')
    end
end