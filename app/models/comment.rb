class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :assignment

  validates :content, presence: true
end
