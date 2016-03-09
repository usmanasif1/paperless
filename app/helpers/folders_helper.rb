module FoldersHelper
  def breadcrumbs(folder, breadcrumbs = '')
	parent_name = Folder.find(folder.parent_id).name
	parent = Folder.find(folder.parent_id)
    breadcrumbs = "<span class=\"breadcrumb nowrap\">#{link_to(parent_name, parent)}</span> &raquo; #{breadcrumbs}"
    breadcrumbs = breadcrumbs(parent, breadcrumbs) unless parent == Folder.find_by_name_and_parent_id('Root folder', nil)
    breadcrumbs.html_safe
  end
end
