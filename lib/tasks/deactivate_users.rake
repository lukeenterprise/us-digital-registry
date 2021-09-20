require "logger"
namespace :users do
    desc "Deactivate Users: Deactivate users who have not logged into the system in last 90 days"
    task :deactivate_users => :environment do
        logger = Logger.new(STDOUT)

        logger.info('Program Name: Deactivate Users')
        logger.info('Description: : Deactivate users who have not logged into the system in last 90 days')

        logger.debug('Program begin')

        logger.debug('Listing all environment keys')
        logger.debug(ENV.keys)

        logger.debug('Querying database to find all users who have not logged into the system for last 90 days')
        logger.debug('email | created_at |last_sign_in_at | last_activated_at | isactive')
        userCount = User.last(100).each do | user |
            logger.debug('email: #{user.email} | #{user.created_at} | #{user.last_sign_in_at} | #{user.last_activated_at} | #{user.isactive}')
            datesToCompare = []
            datesToCompare << user.created_at
            datesToCompare << user.last_sign_in_at
            datesToCompare << user.last_activated_at
            logger.debug('dates')
            logger.debug('dates: #{datesToCompare}')
            maxDate = datesToCompare.max
            logger.debug('dates: #{maxDate}')
            # user.save
        end
        logger.debug('Count of records in users')
        logger.debug(userCount)

        # logger.debug('Update user to set active to false')

        logger.debug('Program Completed')
    end
end