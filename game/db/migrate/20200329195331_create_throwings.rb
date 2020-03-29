class CreateThrowings < ActiveRecord::Migration
  def change
    create_table :throwings do |t|
      t.string :entrada
      t.integer :score

      t.timestamps null: false
    end
  end
end
