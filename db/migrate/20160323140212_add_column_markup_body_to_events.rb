class AddColumnMarkupBodyToEvents < ActiveRecord::Migration
  def change
    add_column :events, :markup_body, :text
  end
end
