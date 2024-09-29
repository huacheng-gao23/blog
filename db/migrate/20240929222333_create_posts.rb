class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.string :category
      t.string :author
      t.datetime :published_at
      t.string :meta_description
      t.string :featured_image

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
