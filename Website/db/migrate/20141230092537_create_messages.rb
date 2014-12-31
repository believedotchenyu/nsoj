class CreateMessages < ActiveRecord::Migration
  	def change
    		create_table :messages do |t|
			t.text :body, limit: 1010, null: false
			t.boolean :read, default: false, null: false
			t.integer :from_user_id, null: false
			t.integer :receive_user_id, null: false

      			t.timestamps null: false
    		end
  	end
end
