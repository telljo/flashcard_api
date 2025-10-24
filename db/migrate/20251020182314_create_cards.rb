class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :front, null: false
      t.string :back, null: false
      t.string :hint
      t.datetime :last_reviewed_at
      t.integer :review_count, default: 0
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
