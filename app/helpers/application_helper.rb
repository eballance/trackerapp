module ApplicationHelper

  def build_title(base, page_title)
    [base, page_title.presence].compact.join(' - ')
  end

  def formatted_minutes(minutes, options = {})
    result = "#{minutes / 60}"
    result << " #{t('entries.hours')}" if options[:legend]
    result << ":" if not options[:legend]
    result << " #{t('entries.and')} " if options[:legend]

    if options[:legend]
      result << "%d" % (minutes % 60)
    else
      result << "%#2.2d" % (minutes % 60)
    end

    result << " #{t('entries.minutes')}" if options[:legend]
    result
  end

  def alert_kind(flash)
      case flash
      when :notice
        'success'
      when :alert
        'warning'
      end
  end

  def nav_item_class(item_name)
    active = case item_name.to_s
             when 'root'
               params[:controller] == 'entries'
             when 'admin'
               ['admin/projects', 'admin/users', 'admin/admin'].include?(params[:controller])
             when 'settings'
               params[:controller] == 'users'
             end

    classes = ['nav-item']
    classes << 'active' if active
    classes.join(" ")
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def i18n_select_options
    I18n.available_locales
  end
end
