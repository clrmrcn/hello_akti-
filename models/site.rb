class Site
  attr_reader :id, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @data = []
  end

  def add_datum(datum)
    @data << datum
  end

  def to_hash
    hash = {}
    category_list.each do |category|
      hash[category.name] = {}
      hash[category.name][:total_value] = sum(category)
      hash[category.name][:emissions] = factor_list(category).map(&:to_hash)
    end
    hash
  end

  def category_list
    @data.map { |datum| datum.emission_factor.emission_category }.uniq
  end

  def factor_list(category)
    data_category(category).map do |datum|
      datum.emission_factor.datum = datum
      datum.emission_factor
    end
  end

  def sum(category)
    sum = 0
    data_category(category).each do |datum|
      sum += (datum.quantity_1 || 1) * (datum.quantity_2 || 1) * datum.emission_factor.all_gaz
    end
    sum
  end

  def data_category(category)
    @data.select { |datum| datum.emission_factor.emission_category == category }
  end
end
