class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :twitter_user_id
      t.string :content, :limit => 140
      t.string :creation_date
      t.timestamps
    end
  end
end
