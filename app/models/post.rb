class Post < ApplicationRecord
	belongs_to :user
	attachment :image

	validates :title, presence: true
	validates :body, presence: true
	validates :steps, presence: true, numericality: true
end
