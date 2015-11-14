class AddTelToImports < ActiveRecord::Migration
  def change
    add_column :imports, :tel, :string
  end
end
