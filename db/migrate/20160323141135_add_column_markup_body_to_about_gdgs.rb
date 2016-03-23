class AddColumnMarkupBodyToAboutGdgs < ActiveRecord::Migration
  def change
    add_column :about_gdgs, :markup_body, :text
  end
end
