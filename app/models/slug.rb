class Slug
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :url, :type => String
  field :slug, :type => String

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>
  index :slug, :unique => true

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
  
  validates_presence_of   :slug, :url
  validates_uniqueness_of :slug
  validates_format_of     :slug, :with => /^[-_[:alnum:]]+$/
  validates_format_of     :url, :with => %r{^https?://}
  
  references_many :accesses
  
  before_validation :expand_slug, :fill_slug
  
  DEFAULT_LETTERS = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  
  class << self
    def find_by_slug(slug)
      where(:slug => slug).first
    end
    
    def find_by_slug!(slug)
      find_by_slug(slug) or raise Sinatra::NotFound
    end
  end
  
  def fullpath(host=Hc::Config[:deployed_host_name])
    "http://#{host || 'localhost'}/#{slug}"
  end
  
  private
    def expand_slug(len=Hc::Config[:slug_default_length])
      if slug.present? && wildcards = slug.scan(/\*/).size
        letters = DEFAULT_LETTERS
        wildcards.times do
          self.slug = slug.sub(/\*/, len.times.map{ letters.sample }.join)
        end
      end
    end

    def fill_slug(len=Hc::Config[:slug_default_length])
      letters = DEFAULT_LETTERS
      self.slug = len.times.map{ letters.sample }.join if slug.blank?
    end
  # end private
end
