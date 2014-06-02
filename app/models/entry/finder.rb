class Entry

  class Finder

    attr_accessor :from, :to

    def initialize(user, options)
      @user = user
      @options = options
      @project_id = options[:project_id]
      @kind = options[:kind] || 'range'
    end

    def entries
      @entries ||= begin
        entries = Entry.for_user(@user).by_date
        entries = entries.for_projects(project.id) if project
        entries = entries.merge(strategy.scope)
        entries.by_date
      end
    end

    def strategy
      @strategy ||= "Entry::Finder::#{@kind.titleize}".constantize.new(@user, @options)
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

    def title
      strategy.title
    end

  end

end
