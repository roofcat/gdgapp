class AddColumnStateToEvents < ActiveRecord::Migration
	def change
		add_column :events, :state, :string, default: "in_draft"
	end
end
