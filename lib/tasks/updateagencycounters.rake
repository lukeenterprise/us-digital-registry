require "logger"
namespace :agencies do
    desc "update agencies counters"
    task :updateagencycounters => :environment do
    
        logger = Logger.new(STDOUT)
        logger.debug('Program begin')
        Agency.all.each do | agencycount |
            agencycount.update_counters
            agencycount.save
        end
      
        logger.debug('Program Completed')
    end
end