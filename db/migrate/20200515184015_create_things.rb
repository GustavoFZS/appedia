class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
      t.string :title
      t.string :type
      t.text :content

      t.timestamps
    end
  end
end
