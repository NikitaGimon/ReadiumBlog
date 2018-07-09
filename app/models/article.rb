class Article < ApplicationRecord
 belongs_to :user
 # many-to-many assotiation
 has_many :article_categories
 has_many :categories, through: :article_categories
 #
 validates :title, presence: true, length: { minimum: 3, maximum: 50}
 validates :description, presence: true, length: { minimum: 3, maximum: 2000}
 validates :user_id, presence: true
end