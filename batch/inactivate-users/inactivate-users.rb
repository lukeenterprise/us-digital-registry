#!/usr/bin/ruby

require "logger"
logger = Logger.new(STDOUT)

logger.info('Program Name: Inactivate Users')
logger.info('Description: Inactivate users who have not logged into the system in last 90 days')

logger.debug('Program begin')

logger.debug('Listing all environment keys')
logger.debug(ENV.keys)

logger.debug('Querying database to find all users who have not logged into the system for last 90 days')
logger.debug('Update user to set active to false')

logger.debug('Program Completed')
