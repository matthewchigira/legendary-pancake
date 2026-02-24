require "faker"

puts "Seeding database..."

PANCAKE_ADJECTIVES = %w[
  Fluffy Crispy Golden Legendary Epic Mythical Classic Grandma's Heavenly
  Supreme Ultimate Perfect Rustic Artisan Gourmet Decadent Towering
  Buttery Maple Blueberry Chocolate Banana Cinnamon Lemon Strawberry
  Nutella Pumpkin Apple Pecan Coconut Matcha Lavender Honey Oat
  Buckwheat Sourdough Protein Ancient Whole\ Wheat Cornmeal Ricotta
].freeze

DIFFICULTIES = %w[easy medium hard].freeze

UNITS = %w[cup cups tsp tbsp oz g ml lb pinch dash whole].freeze

INGREDIENT_NAMES = %w[
  flour sugar milk eggs butter salt baking\ powder baking\ soda
  vanilla\ extract cinnamon nutmeg maple\ syrup honey buttermilk
  cream\ cheese ricotta yogurt coconut\ oil vegetable\ oil
  lemon\ juice blueberries strawberries bananas chocolate\ chips
  cocoa\ powder whipped\ cream pecans walnuts oats cornmeal
].freeze

Recipe.destroy_all

100.times do |i|
  adjective = PANCAKE_ADJECTIVES.sample
  style = ["Pancakes", "Pancake Stack", "Flapjacks", "Hotcakes", "Griddle Cakes"].sample
  recipe = Recipe.create!(
    name: "#{adjective} #{style}",
    description: Faker::Lorem.paragraph(sentence_count: rand(3..6)),
    difficulty: DIFFICULTIES.sample,
    prep_time_minutes: rand(5..30),
    cook_time_minutes: rand(10..45),
    servings: rand(2..12),
    image_url: nil
  )

  rand(3..8).times do
    recipe.ingredients.create!(
      name: INGREDIENT_NAMES.sample,
      quantity: ["1/4", "1/3", "1/2", "3/4", "1", "1 1/2", "2", "3"].sample,
      unit: UNITS.sample
    )
  end

  rand(0..5).times do
    recipe.reviews.create!(
      author_name: Faker::Name.first_name,
      rating: rand(1..5),
      comment: Faker::Lorem.sentence(word_count: rand(5..20))
    )
  end

  print "." if (i + 1) % 10 == 0
end

puts ""
puts "Seeded #{Recipe.count} recipes"
puts "Seeded #{Ingredient.count} ingredients"
puts "Seeded #{Review.count} reviews"
