class AddActiveUser < ActiveRecord::Migration[5.2]
    def change   
      add_column :users, :isactive, :boolean, :default => true
      add_column :users, :last_activated_at, :datetime
    end
end