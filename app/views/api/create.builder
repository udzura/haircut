xml.instruct! :xml, :version => '1.0'
xml.api do
  xml.name "api-create-url-xml"
  xml.url @slug.fullpath(request.host)
  xml.created_at(@slug.created_at)
end
