class AddAccessTokenFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string
    add_column :users, :access_token_expiry, :datetime
  end
end
