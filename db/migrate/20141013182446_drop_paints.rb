class DropPaints < ActiveRecord::Migration
  def change
    drop_table :paints
  end
end
