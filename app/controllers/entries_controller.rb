require 'configatron'

class User

  attr_accessor :name, :entries, :total

  def initialize(name, entries)
    @name = name
    @entries = entries
    @total = entries.sum(:minutes)
    puts @name
    puts @total
  end

end

class EntriesController < ApplicationController
    def index
        @from = if params[:from]
          Date.strptime(params[:from], '%m/%d/%Y')
        else
          Date.new(Date.today.year, Date.today.month, 1)
        end

        @previous_month = (@from - 1.month).at_beginning_of_month
        @next_month = (@from + 1.month).at_beginning_of_month

        configuration = YAML.load_file(Rails.root.join('config', 'config.yml'))

        @users = []
        configuration.each do |name, attrs|
            @user = User.new(name, Entry.where(user: name).where('date >= ?', @from).order('date desc'))
            @users.append(@user)
        end
    end
end