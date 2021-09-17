require "logger"
namespace :users do
    desc "Deactivate Users: Deactivate users who have not logged into the system in last 90 days"
    task :deactivate_users do
        logger = Logger.new(STDOUT)

        logger.info('Program Name: Deactivate Users')
        logger.info('Description: : Deactivate users who have not logged into the system in last 90 days')

        logger.debug('Program begin')

        logger.debug('Listing all environment keys')
        logger.debug(ENV.keys)

        logger.debug('Querying database to find all users who have not logged into the system for last 90 days')
        userCount = User.all.count
        # results = ActiveRecord::Base.connection.execute("select count(1) from users")
        logger.debug('Count of records in users')
        logger.debug(userCount)

        # logger.debug('Update user to set active to false')

        logger.debug('Program Completed')
    end
end