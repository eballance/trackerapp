class EntryForm < Form

  attr_accessor :time_spent, :project_id, :date, :description, :links, :user_id, :minutes

  validates :time_spent, presence: true
  validates :date, presence: true
  validates :minutes, presence: true

  def initialize(attributes = {})
    if attributes[:user]
      latest_entry = attributes.delete(:user).entries.by_created_at.first
      @project_id = latest_entry.project_id if latest_entry
    end

    return if attributes.blank?

    @date = Date.parse(attributes.delete(:date))
    store(attributes)
    @minutes = TimeParser.new(attributes.delete(:time_spent)).minutes rescue nil
    @entry = Entry.new(attributes)
    @entry.minutes = @minutes
    @entry.date = @date
  end

  def submit
    valid? && @entry.save
  end

  def date_in_words
    # if date was set to today, or wasn't set at all
    if (@date.present? && @date == Date.current) || @date.blank?
      I18n.t('entries.today_change').html_safe
    else
      I18n.l(@date, :format => "d% %B, %Y")
    end
  end
end
