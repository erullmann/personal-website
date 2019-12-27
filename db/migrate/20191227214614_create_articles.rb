class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :title
      t.text :body
      t.datetime :publish_date
      t.datetime :removed_at
      t.references :admin, foreign_key: true
      t.string :location
      t.string :source
      t.string :emoji

      t.timestamps
    end
  end
end
