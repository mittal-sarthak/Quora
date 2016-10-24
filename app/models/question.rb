class Question < ActiveRecord::Base
	belongs_to :author, class_name: "User", foreign_key: 'author_id'
	belongs_to :moderator, class_name: "User", foreign_key: 'moderator_id'
	has_many :answers
end
