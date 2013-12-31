require "httparty"

require File.expand_path('../config/application', __FILE__)

Trackerapp::Application.load_tasks

namespace :tracker do
  task :import => :environment do
    User.all.each do |user|
      user.new_entries.each do |hash|
        entry = user.entry.build(hash)
        puts "Failed importing for: #{hash}, #{entry.errors.inspect}" if not entry.save
      end
    end
  end

  task :export => :environment do

    Entry.where(exported: false).each do |entry|
      next if entry.description.blank?
      user = settings.users.detect{|name, attrs| name == entry.user }
      apikey = user[1]['minutedock_apikey']
      next if apikey.blank?
      url = "https://minutedock.com/api/v1/entries.json?api_key=#{apikey}"
      body = {
        entry: {
          duration: entry.minutes * 60,
          description: entry.description,
          logged_at: entry.date.to_time
        }
      }
      response = HTTParty.post(url, body: body)
      entry.update_column(:exported, true) if response.code == 200
    end

  end

  task :fix do
    Entry.where(user: 'josef').where("date >= ?", Date.new(2013, 9, 1)).destroy_all
  end

end
