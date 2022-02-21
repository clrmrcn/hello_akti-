require_relative './models/site'
require_relative './models/activity_datum'
require_relative './models/factor'
require_relative './models/category'
require 'json'

json_input_path = './data/input.json'
hash_input = JSON.parse(File.read(json_input_path))

categories = {}
hash_input['emission_categories'].each do |c|
  category = Category.new(id: c['id'], name: c['name'])
  categories[category.id] = category
end

sites = {}
hash_input['sites'].each do |s|
  site = Site.new(id: s['id'], name: s['name'])
  sites[site.id] = site
end

factors = {}
hash_input['emission_factors'].each do |f|
  factor = Factor.new(id: f['id'], description: f['description'], emission_category: categories[f['emission_categorie_id']], unit_1: f['unit_1'], unit_2: f['unit_2'], value_co2: f['value_co2'], value_ch4: f['value_ch4'], value_n2o: f['value_n2o'], value_co2b: f['value_co2b'], value_ch4b: f['value_ch4b'])
  factors[factor.id] = factor
end

data = {}
hash_input['activity_data'].each do |d|
  datum = ActivityDatum.new(id: d['id'], emission_factor: factors[d['emission_factor_id']], area: sites[d['area_id']], quantity_1: d['quantity_1'], quantity_2: d['quantity_2'])
  data[datum.id] = datum
end

output = {}
sites.each do |id, site|
  output[site.name] = site.to_hash
end

File.open('data/output.json', "wb") do |file|
  file.write(JSON.pretty_generate(output))
end
