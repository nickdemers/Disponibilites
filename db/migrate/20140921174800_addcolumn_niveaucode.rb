class AddcolumnNiveaucode < ActiveRecord::Migration
  def change
    add_column :niveaus, :code, :integer
  end
end