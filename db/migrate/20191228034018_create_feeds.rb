class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.text :url
      t.string :name
      t.datetime :last_fetched_at
      t.integer :minutes_between_fetches
      t.references :admin, foreign_key: true

      t.timestamps
    end

    add_reference :articles, :feed, foreign_key: true
  end
end
