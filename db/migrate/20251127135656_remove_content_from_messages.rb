class RemoveContentFromMessages < ActiveRecord::Migration[8.1]
  def change
    remove_column :messages, :content, :text
  end
end
