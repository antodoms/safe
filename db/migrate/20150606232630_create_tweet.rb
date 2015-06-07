class CreateTweet < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
    	t.datetime :created
    	t.integer :score , :users
    	t.string :handle
    	t.text :tweet
    end
  end
end
