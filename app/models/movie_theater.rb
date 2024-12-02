class MovieTheater < ApplicationRecord
  validates :name, :city, presence: true
  has_many :rooms

  def sessions
    sessions = []
    self.rooms.each do |room|
      sessions << room.sessions if !room.sessions.empty?
    end

    return sessions.flatten
  end
end
