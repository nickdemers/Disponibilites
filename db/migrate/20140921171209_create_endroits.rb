class CreateEndroits < ActiveRecord::Migration
  def change
    create_table :endroits do |t|
      t.string :nom
      t.string :adresse
      t.string :numero_telephone
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
