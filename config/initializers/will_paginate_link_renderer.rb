# see http://web.elctech.com/2010/02/25/using-will_paginate-in-sinatra/

WillPaginate::ViewHelpers::LinkRenderer.class_eval do
  protected
  def url(page)
    url = @template.request.url
    case url
    when /\/[0-9]+\/?(\?.*)?$/
      (page < 2) ?
          url.gsub!(/(\/)([0-9]+)(\/?(?:\?.*)?)$/, "\\3") :
          url.gsub!(/(\/)([0-9]+)(\/?(?:\?.*)?)$/, "\\1#{page}\\3")
      url.gsub!(/page=[0-9]+/, "")
    when /\?.*page=[0-9]+/
      (page < 2) ?
          url.gsub!(/page=[0-9]+/, "") :
          url.gsub!(/page=[0-9]+/, "page=#{page}")
    else
      url.sub!(/\/$/, "")
      url << "/#{page}"
    end
    return url.gsub(/\?$/, '')
  end
end
