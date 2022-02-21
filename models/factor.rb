class Factor
  attr_reader :id, :emission_category
  attr_accessor :datum

  def initialize(attributes = {})
    @id = attributes[:id]
    @description = attributes[:description]
    @unit_1 = attributes[:unit_1]
    @unit_2 = attributes[:unit_2]
    @value_co2 = attributes[:value_co2]
    @value_ch4 = attributes[:value_ch4]
    @value_n2o = attributes[:value_n2o]
    @value_co2b = attributes[:value_co2b]
    @value_ch4b = attributes[:value_ch4b]
    @emission_category = attributes[:emission_category]
  end

  def all_gaz
    (@value_co2 || 0) + (@value_ch4 || 0) + (@value_n2o || 0) + (@value_ch4b || 0)
  end

  def to_hash
    {
      id: @id,
      description: @description,
      unit: "kgCO2e/#{@unit_1}" + (@unit_2 ? ".#{@unit_2}" : ""),
      total_value: all_gaz * (@datum.quantity_1 || 1) * (@datum.quantity_2 || 1),
      value_co2: @value_co2 ? @value_co2 * (@datum.quantity_1 || 1) * (@datum.quantity_2 || 1) : nil,
      value_ch4: @value_ch4 ? @value_ch4 * (@datum.quantity_1 || 1) * (@datum.quantity_2 || 1) : nil,
      value_n2o: @value_n2o ? @value_n2o * (@datum.quantity_1 || 1) * (@datum.quantity_2 || 1) : nil,
      value_co2b: @value_co2b ? @value_co2b * (@datum.quantity_1 || 1) * (@datum.quantity_2 || 1) : nil,
      value_ch4b: @value_ch4b ? @value_ch4b * (@datum.quantity_1 || 1) * (@datum.quantity_2 || 1) : nil,
      activity_datum_id: @datum.id
    }
  end
end
