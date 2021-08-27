class AddActiveUser< ActiveRecord::Migration
    def change   
      add_column :users, :isactive, :boolean, :default => true
      add_column :users, :last_activated_at, :datetime
    end
end