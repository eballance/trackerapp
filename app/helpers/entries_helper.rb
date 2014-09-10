module EntriesHelper

  def link_to_entries(text, kind, current_kind, options = {})
    classes = options.delete(:class) || ""
    classes << ' active' if current_kind == kind

    link_to text, params.merge(kind: kind), options.merge(class: classes)
  end

end