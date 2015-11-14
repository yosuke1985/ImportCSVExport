class AddLocationToImports < ActiveRecord::Migration
  def change
    add_column :imports, :location, :string
  end
end
