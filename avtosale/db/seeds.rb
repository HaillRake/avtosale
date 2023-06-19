# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

seed_file = Rails.root.join('db/seeds/db.yml')
data = YAML.load_file(seed_file)
data.map do |car|
  car.shift
  car['date_added'] = Date.strptime(car['date_added'], '%d/%m/%y').strftime('%Y-%m-%d')
end
Car.create(data)
