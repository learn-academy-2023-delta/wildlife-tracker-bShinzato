class Animal < ApplicationRecord
    has_many :sightings, through: :information
    has_many :information
end
