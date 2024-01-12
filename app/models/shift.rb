class Shift < ApplicationRecord
    belongs_to :reservation, optional: true # nullを許す
    belongs_to :stylist
end
