class AddFaxToImports < ActiveRecord::Migration
  def change
    add_column :imports, :fax, :string
  end
end
