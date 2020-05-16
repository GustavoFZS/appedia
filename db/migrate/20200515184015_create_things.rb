class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
      t.string :title
      t.string :type
      t.text :desc

      t.timestamps
    end
  end
end
