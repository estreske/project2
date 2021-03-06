class Definition < ActiveRecord::Base
  attr_accessible :content, :player_id, :round_id, :round, :player

  belongs_to :player
  belongs_to :round
  has_many :picks
end
