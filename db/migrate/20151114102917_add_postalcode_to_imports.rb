class AddPostalcodeToImports < ActiveRecord::Migration
  def change
    add_column :imports, :postalcode, :string
  end
end
