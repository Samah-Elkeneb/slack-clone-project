class AddPublicToChannels < ActiveRecord::Migration[8.1]
  def change
    add_column :channels, :public, :boolean, null: false, default: true
  end
end
