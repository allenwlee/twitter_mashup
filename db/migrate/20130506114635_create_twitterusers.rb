class CreateTwitterusers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :screen_name, :location
    end
  end
end
