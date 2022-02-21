class ActivityDatum
  attr_reader :id, :emission_factor, :quantity_1, :quantity_2

  def initialize(attributes = {})
    @id = attributes[:id]
    @emission_factor = attributes[:emission_factor]
    @area = attributes[:area]
    @area.add_datum(self)
    @quantity_1 = attributes[:quantity_1]
    @quantity_2 = attributes[:quantity_2]
  end
end
