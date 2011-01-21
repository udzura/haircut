class Hc::Config
  CONF = YAML.load(ERB.new(open(Padrino.root + "/config/haircut_config.yml").read).result)

  class << self
    def [](key)
      self::CONF[key]
    end
  end
end
