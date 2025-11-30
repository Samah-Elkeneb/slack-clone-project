class AddCreatorToChannels < ActiveRecord::Migration[8.1]
  def change
    add_reference :channels, :creator, foreign_key: { to_table: :users }
  end
end
