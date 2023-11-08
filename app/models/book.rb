class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      Book.where("title like ?","#{word}")
    elsif search == "forward_match"
      Book.where("title like ?","#{word}%")
    elsif search == "backward_match"
      Book.where("title like ?","%#{word}")
    elsif search == "partial_match"
      Book.where("title like ?","%#{word}%")
    else
      Book.all
    end
  end

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
