class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :header
      t.text :lines
      t.text :blank
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
