class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :youtube_id
      t.string :title
      t.text :description
      t.integer :like
      t.integer :dislike
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
