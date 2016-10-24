class AddModeratorIdToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :moderator_id, :integer
  	add_column :questions, :author_id, :integer
  	remove_column :questions, :user_id
  end
end
