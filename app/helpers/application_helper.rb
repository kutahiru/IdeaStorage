module ApplicationHelper
  def page_title(title = "")
    base_title = t("layouts.application.title")
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
