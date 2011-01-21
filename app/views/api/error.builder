xml.instruct! :xml, :version => '1.0'
xml.api do
  xml.result "error"
  xml.status_code 500
  xml.errors do
    @slug.errors.full_messages.each do |msg|
      xml.error_message {xml.cdata!(msg)}
    end
  end
end
