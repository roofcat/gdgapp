class CreateAboutGdgs < ActiveRecord::Migration
  def change
    create_table :about_gdgs do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
