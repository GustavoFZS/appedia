class AddLastSearchToTag < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :last_search, :datetime
  end
end
