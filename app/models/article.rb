class Article < ActiveRecord::Base

	include AASM

	belongs_to :user

	has_many :comments, as: :commentable
	has_many :has_categories
	has_many :categories, through: :has_categories

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}

	before_create :set_visits_count
	after_create :save_categories

	has_attached_file :cover, styles: { medium: "1280x720", thumb: "800x600" }
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	scope :publicados, -> { where(state: 'published').order('created_at DESC') }
	scope :pendientes, -> { where(state: 'in_draft').order('created_at') }
	scope :ultimos, -> { order('created_at DESC').limit(5) }


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
		unless @categories.nil?
			@categories.each do |category_id|
				HasCategory.create(category_id: category_id, article_id: self.id)
			end
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
