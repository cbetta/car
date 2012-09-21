class AddMsgTypeToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :msg_type, :string
  end
end
