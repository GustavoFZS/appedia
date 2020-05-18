class AddTagsToThings < ActiveRecord::Migration[5.2]
  def change
    add_column :things, :raw_tags, :text
  end
end
