class Article < ActiveRecord::Base

	include AASM

	belongs_to :user

	has_many :comments
	has_many :has_categories
	has_many :categories, through: :has_categories

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}

	before_create :set_visits_count
	after_create :save_categories

	scope :publicados, -> { where(state: 'published') }
	scope :ultimos, -> { order('created_at DESC') }

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	def set_visits_count
		self.visits_count ||= 0
	end

	def categories=(value)
		@categories = value
	end

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, article_id: self.id)
		end
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
