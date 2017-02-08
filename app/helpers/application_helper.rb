module ApplicationHelper
  def strip_url(url)
    url.sub!(/https\:\/\/www./, '') if url.include? "https://www."
    url.sub!(/http\:\/\/www./, '')  if url.include? "http://www."
    url.sub!(/www./, '')            if url.include? "www."
    url
  end

  def menu_link(text, path, link_class="", **options)
    options.merge!(class: "is-active") if current_page?(path)
    content_tag(:li, options) do
      link_to text, path, class: link_class
    end
  end
end
