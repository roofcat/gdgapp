class Event < ActiveRecord::Base

	include AASM
  	
  	belongs_to :user

  	has_many :comments, as: :commentable

  	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }

	before_create :set_visits_count

	has_attached_file :cover, styles: { medium: "1280x720", thumb: "800x600" }
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	scope :publicados, -> { order('created_at DESC') }
	scope :ultimos, -> { order('created_at DESC').limit(5) }

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	def set_visits_count
		self.visits_count ||= 0
	end

	aasm column: "state" do
		state :in_draft, initial: true
		state :published

		event :published do
			transitions from: :in_draft, to: :published
		end

		event :unpublished do
			transitions from: :published, to: :in_draft
		end

	end
  	
end
