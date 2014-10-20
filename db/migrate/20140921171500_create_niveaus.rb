class CreateNiveaus < ActiveRecord::Migration
  def change
    create_table :niveaus do |t|
      t.string :nom
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
