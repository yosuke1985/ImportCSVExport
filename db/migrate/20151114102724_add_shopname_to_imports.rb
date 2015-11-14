class AddShopnameToImports < ActiveRecord::Migration
  def change
    add_column :imports, :shopname, :string
  end
end
