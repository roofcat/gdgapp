class Event < ActiveRecord::Base
  	
  	belongs_to :user

  	has_many :comments, as: :commentable

  	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }

	before_create :set_visits_count

	scope :publicados, -> { order('created_at DESC') }
	scope :ultimos, -> { order('created_at DESC').limit(5) }

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	def set_visits_count
		self.visits_count ||= 0
	end
  	
end
