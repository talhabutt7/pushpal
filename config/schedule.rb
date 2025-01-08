# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :output, "log/cron_log.log"

# Schedule the task to run daily at a specific time (e.g., 12:00 pm)
every 1.day, at: '12:00 pm' do
  rake "auto_commit:push_daily"
end
