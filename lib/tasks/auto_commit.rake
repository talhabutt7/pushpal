require 'octokit'

namespace :auto_commit do
  desc "Make daily commits and push to GitHub"
  task push_daily: :environment do
    repo_name = ENV['REPO_NAME']
    token = ENV['GITHUB_TOKEN']
    client = Octokit::Client.new(access_token: token)

    # Fetch the current time and create a commit message
    current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    commit_message = "Auto commit at #{current_time}"

    # Create a temporary file with a random change
    file_path = "log/auto_commit_log.txt"
    File.open(file_path, 'a') { |f| f.puts("Commit at #{current_time}") }

    # Add, commit, and push changes
    `git add #{file_path}`
    `git commit -m "#{commit_message}"`
    `git push origin main`

    puts "Committed and pushed changes to #{repo_name} at #{current_time}"
  end
end


# namespace :auto_commit do
#   desc "Generate random commits and push to GitHub"
#   task push_daily: :environment do
#     require 'securerandom'
#     require 'time'
#
#     # Configuration: Set the path to your local Git repository
#     repo_path = "/path/to/your/repo"  # Change this to your actual repo path
#
#     # Set the range for the number of commits per day
#     min_commits = 15
#     max_commits = 30
#
#     # Randomly determine how many commits to make today
#     commit_count = rand(min_commits..max_commits)
#
#     # Define a list of possible commit messages
#     commit_messages = [
#       "Refactor code",
#       "Improve documentation",
#       "Fix minor bug",
#       "Update dependencies",
#       "Enhance performance",
#       "Add new feature",
#       "Code cleanup"
#     ]
#
#     # Change directory to the local Git repository
#     Dir.chdir(repo_path) do
#       commit_count.times do
#         # Create a dummy file to commit (simulating changes)
#         filename = "dummy_file_#{SecureRandom.hex(4)}.txt"
#         File.write(filename, "Commit at #{Time.now}")
#
#         # Stage the file and create a commit
#         `git add .`
#         message = commit_messages.sample
#         `git commit -m "#{message}"`
#         puts "Committed: #{message}"
#       end
#
#       # Push all commits to the remote Git repository
#       `git push origin main`
#       puts "Pushed #{commit_count} commits to GitHub."
#     end
#   rescue => e
#     puts "Error: #{e.message}"
#   end
# end
