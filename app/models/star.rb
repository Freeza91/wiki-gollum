class Star < ActiveRecord::Base

  validates :user_id, precense: true
  validates :wiki_name, presence: true

  belongs_to :user
end
