class Sighting < ApplicationRecord
    # belongs_to :animal
    has_many :animals, through: :information
    has_many :information
end
