class Entry

  class Finder

    KINDS = ['range', 'this_month', 'last_month']

    attr_accessor :kind

    def initialize(options = {})
      @options = options
      @kind    = options[:kind] || 'this_month'
      @from    = options[:from] || 1.month.ago.to_date.to_s
      @to      = options[:to] || Date.today.to_s
    end

    def user
      @user ||= if @options[:user]
                  @options.delete(:user)
                elsif @options[:user_id].present?
                  project.users.find(@options.delete(:user_id))
                end
    end

    def project
      @project  ||= if @options[:project]
                      @options.delete(:project)
                    elsif @options[:project_id].present?
                      user.projects.find(@options.delete(:project_id))
                    end
    end

    def entries
      @entries ||= begin
        entries = Entry.by_date.merge(Entry.between(from, to))
        entries = entries.for_user(@user) if user
        entries = entries.for_project(project.id) if project
        entries
      end
    end

    def from
      @from ||= begin
        case kind
        when 'this_month'
          Date.current.at_beginning_of_month.to_date
        when 'last_month'
          (Date.current.at_beginning_of_month - 1.month).to_date
        when 'range'
          Date.parse(@from)
        end
      end
    end

    def to
      @to ||= begin
        case kind
        when 'this_month'
          Date.current.at_end_of_month.to_date
        when 'last_month'
          (Date.current.at_beginning_of_month - 1.month).at_end_of_month.to_date
        when 'range'
          Date.parse(@to)
        end
      end
    end

    def project_name
      project.try(:name).presence || "All projects"
    end

    def total
      @total ||= entries.sum(:minutes)
    end

    def collaborators
      @collaborators ||= User.where id: @entries.pluck(:user_id).uniq
    end

  end

end
