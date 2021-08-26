class AddActiveUser< ActiveRecord::Migration
    def change   
      add_column :users, :active, :boolean
      add_column :users, :last_activated_at, :datetime
    end
end