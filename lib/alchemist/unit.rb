module Alchemist
  class Unit
    include Comparable
    attr_accessor :definition, :value

    def initialize(definition, value)
      @definition = definition
      @value = value
    end

    def to(unit_name)
      to_definition = Alchemist.definition(unit_name)
      Alchemist::Unit.new(to_definition, value * to_definition.value / @definition.value)
    end

    def <=>(other_unit)
      other_unit.to(@definition.name).value.to_f <=> value.to_f
    end

    def ==(other_unit)
      self <=> other_unit
    end

  end
end
