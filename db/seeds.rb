# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

animal_a = Animal.create(common_name: "Black-Capped Chickadee", scientific_binomial: "Poecile Atricapillus")
animal_b = Animal.create(common_name: "Grackle", scientific_binomial: "Quiscalus Quiscula")
animal_c = Animal.create(common_name: "Common Starling", scientific_binomial: "Sturnus Vulgaris")
animal_d = Animal.create(common_name: "Mourning Dove", scientific_binomial: "Zenaida Macroura")

sighting_a = Sighting.create(latitude: "40.730610", longitude: "-73.935242", date:"2023-06-11", animal_id: 1)
sighting_b = Sighting.create(latitude: "30.26715", longitude: "-97.74306", date:"2023-06-14", animal_id: 2)
sighting_c = Sighting.create(latitude: "45.512794", longitude: "-122.679565", date:"2023-06-17", animal_id: 3)

information_a = Information.create(animal: animal_a, sighting: sighting_b)
information_b = Information.create(animal: animal_b, sighting: sighting_a)
information_c = Information.create(animal: animal_c, sighting: sighting_a)
information_d = Information.create(animal: animal_d, sighting: sighting_c)
information_e = Information.create(animal: animal_a, sighting: sighting_b)