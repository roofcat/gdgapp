class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :company
      t.string :position
      t.text :comment
      t.boolean :receive_information

      t.timestamps null: false
    end
  end
end
