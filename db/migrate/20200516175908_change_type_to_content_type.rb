class ChangeTypeToContentType < ActiveRecord::Migration[5.2]
  def change
    rename_column :things, :type, :content_type
  end
end
