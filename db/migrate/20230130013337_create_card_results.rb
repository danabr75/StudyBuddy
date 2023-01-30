class CreateCardResults < ActiveRecord::Migration[7.0]
  def change
    create_table :card_results do |t|
      t.references :result, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
