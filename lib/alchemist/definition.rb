module Alchemist
  class Definition
    attr_accessor :measurement, :name, :value
    attr_accessor :plural_name
    attr_accessor :short_names, :aliases

    def initialize(measurement, name, value)
      @measurement = measurement
      @name = name
      @value = value
      @short_names = []
      @aliases = {}
    end

    def plural(value)
      @plural_name = value
    end

    def short(*names)
      @short_names += names
    end

    def add_alias(aliases)
      aliases = { aliases => aliases } unless aliases.is_a?(Hash)
      @aliases.merge!(aliases)
    end

    def each_name
      [@name, @plural_name, @short_names, [*@aliases].uniq].flatten.compact.each do |name|
        yield name
      end
    end

  end
end
