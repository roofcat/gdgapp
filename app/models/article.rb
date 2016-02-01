class Article < ActiveRecord::Base

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}

	before_create :set_visits_count

	scope :ultimos, -> { order('created_at DESC') }

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	def set_visits_count
		self.visits_count ||= 0
	end
end
