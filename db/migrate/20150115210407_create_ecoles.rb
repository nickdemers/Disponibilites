class CreateEcoles < ActiveRecord::Migration
  def change
    create_table :ecoles do |t|
      t.string :nom
      t.string :adresse
      t.string :numero_telephone

      t.timestamps
    end
  end
end
