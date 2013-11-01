require 'sinatra'
require 'sinatra/config_file'
require 'date'
require 'letsfreckle'
require 'sinatra/activerecord'
require 'csv'

require_relative 'user'
require_relative 'entry'

set :database_file, 'config/database.yml'

class Tracker < Sinatra::Base

  register Sinatra::ConfigFile
  config_file 'config/config.yml'

  register Sinatra::ActiveRecordExtension

  get '/' do
    @from = if params[:from]
          Date.strptime(params[:from], '%m/%d/%Y')
        else
          Date.new(Date.today.year, Date.today.month, 1)
        end

    @previous_month = (@from - 1.month).at_beginning_of_month
    @next_month = (@from + 1.month).at_beginning_of_month

    @users = settings.users.map do |name, attrs|
      User.new(name, Entry.where(user: name).where('date >= ?', @from).order('date desc'))
    end

    erb :index

  end

end

