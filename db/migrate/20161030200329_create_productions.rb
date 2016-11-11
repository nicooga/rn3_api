class CreateProductions < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :permalink
      t.text :description
      t.string :meli_id, index: true
      t.text :pictures, array: true, default: []

      t.timestamps
    end
  end
end
