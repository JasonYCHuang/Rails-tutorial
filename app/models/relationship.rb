class Relationship < ActiveRecord::Base
  	# ===== callbacks =====

	# ===== validation =====
	validates :follower_id, presence: true
  	validates :followed_id, presence: true

	# ===== model relationship =====
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"

	# * * * * * * * * * * * * * * 
end
