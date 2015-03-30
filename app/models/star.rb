class Star < ActiveRecord::Base

  validates :user_id, presence: true
  validates :wiki_name, presence: true

  belongs_to :user
end
