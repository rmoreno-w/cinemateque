class Session < ApplicationRecord
  belongs_to :movie
  belongs_to :room
end
