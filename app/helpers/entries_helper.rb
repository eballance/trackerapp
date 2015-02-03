module EntriesHelper

  def link_to_entries(text, kind, current_kind, options = {})
    classes = options.delete(:class) || ""
    classes << (current_kind == kind ? ' active' : ' inactive')

    link_to text, params.merge(kind: kind), options.merge(class: classes)
  end

  def collaborator_names(entries)
    entries.collaborators.map(&:username).join(', ')
  end
end
