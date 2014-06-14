class Entry

  class Finder

    KINDS = ['range', 'this_month', 'last_month']

    attr_accessor :kind

    def initialize(user, options)
      @user = user
      @options = options
      @project_id = options[:project_id]
      @kind = options[:kind] || 'this_month'
    end

    def entries
      @entries ||= begin
        entries = Entry.for_user(@user).by_date
        entries = entries.for_project(project.id) if project
        entries = entries.merge(Entry.between(from, to))
        entries.by_date
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
          Date.parse(@options[:from])
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
          Date.parse(@options[:from])
        end
      end
    end

    def project
      @project ||= @user.projects.find(@project_id) if @project_id.present?
    end

    def project_name
      project.try(:name)
    end

    def total
      @total ||= entries.sum(:minutes)
    end

  end

end
