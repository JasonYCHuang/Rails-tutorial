class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable, :confirmable

	# ===== callbacks =====
	before_save { email.downcase }

	# ===== validation =====
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	                format: { with: VALID_EMAIL_REGEX },
	                uniqueness: { case_sensitive: false }

	# ===== model relationship =====
	has_many :microposts, dependent: :destroy

	# * * * * * * * * * * * * * * 
	def feed
	    Micropost.where("user_id = ?", id)
	end
end
