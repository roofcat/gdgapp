class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :body
      t.integer :visits_count, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
