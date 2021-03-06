module ApplicationHelper
  def strip_url(url)
    url.sub!(/https\:\/\/www./, '') if url.include? "https://www."
    url.sub!(/http\:\/\/www./, '')  if url.include? "http://www."
    url.sub!(/www./, '')            if url.include? "www."
    url
  end

  def menu_link(text, path, **options)
    options.merge!(class: "is-active") if current_page?(path)
    content_tag(:li, options) do
      link_to(text, path, class: options[:link_class] || "")
    end
  end

  def hide_subnav?
    !user_signed_in? || subnav_hidden? || devise_controller?
  end

  def time_in_words(time)
    distance_of_time_in_words(Time.at(0), Time.at(time))
  end

  def format_time(time, format: :day_and_mo)
    return "N/A" unless time
    time.to_s(format)
  end
end
