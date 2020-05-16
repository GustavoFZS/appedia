class CreateJoinTableTagsThings < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tags, :things do |t|
      t.index [:tag_id, :thing_id]
      t.index [:thing_id, :tag_id]
    end
  end
end
