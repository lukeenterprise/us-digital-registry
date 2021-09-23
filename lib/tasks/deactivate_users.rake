require "logger"
namespace :users do
    desc "Deactivate Users: Deactivate users who have not logged into the system in last 90 days"
    task :deactivate_users => :environment do
        NUMBER_OF_DAYS_TO_INACTIVE = 90
        logger = Logger.new(STDOUT)

        logger.info('Program Name: Deactivate Users')
        logger.info('Description: : Deactivate users who have not logged into the system in last 90 days')

        logger.debug('Program begin')

        logger.debug('Querying database to find all users who have not logged into the system for last 90 days')
        logger.debug('email | created_at |last_sign_in_at | last_activated_at | isactive')
        numberOfRecordsUpdates = 0
        User.all.each do | user |
            datesToCompare = []

            if user.created_at.try(:to_date)
                datesToCompare << user.created_at.to_date
            end
            if user.last_sign_in_at.try(:to_date)
                datesToCompare << user.last_sign_in_at.to_date
            end
            if user.last_activated_at.try(:to_date)
                datesToCompare << user.last_activated_at.to_date
            end

            maxDate = datesToCompare.max
            numberOfDaysSinceLastActivity = (Date.today.to_date  - maxDate.to_date).to_i

            if(numberOfDaysSinceLastActivity > NUMBER_OF_DAYS_TO_INACTIVE && user.isactive)
                logger.debug("User Data: email: #{user.email} | #{user.created_at} | #{user.last_sign_in_at} | #{user.last_activated_at} | #{user.isactive}")
                user.isactive = FALSE
                user.save     
                numberOfRecordsUpdates = numberOfRecordsUpdates + 1           
            end
        end
        logger.debug("Number of users inactivated is #{numberOfRecordsUpdates}")
        logger.debug('Program Completed')
    end
end