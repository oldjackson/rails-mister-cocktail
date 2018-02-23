require 'open-uri'

ingr_url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

resp_serialized = open(ingr_url).read
ingr_hash_arr = JSON.parse(resp_serialized)["drinks"]

ingr_hash_arr.each do |ingr_hash|
  Ingredient.create(name: ingr_hash["strIngredient1"])
end
