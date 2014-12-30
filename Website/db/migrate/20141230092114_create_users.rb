class CreateUsers < ActiveRecord::Migration
	def change
    		create_table :users do |t|
			t.string :username, limit: 30, null: false
			t.string :password, limit: 35, null: false
			t.string :realname, limit: 20
			t.string :email, limit: 110
			t.string :create_ip, limit: 30, null: false
			t.string :school
			t.integer :solved_count, default: 0, null: false
			t.integer :accepted_count, default: 0, null: false
			t.integer :submission_count, default: 0, null: false
			t.integer :level, default: 0, null: false

      			t.timestamps null: false
    		end
  	end
end
