class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :slug
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tweets, :slug, unique: true
  end
end
