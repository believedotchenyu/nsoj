class CreateSubmissions < ActiveRecord::Migration
  	def change
    		create_table :submissions do |t|
			t.integer :time, defualt: 0, null: false
			t.integer :memory, defualt: 0, null: false
			t.string :submit_ip, limit: 30, null: false
			t.integer :score, defualt: 0, null: false
			t.integer :source_length, defualt: 0, null: false
			t.integer :submission_score, defualt: 0, null: false
			t.integer :task, defualt: 0, null: false
			t.references :user
			t.references :statistic
			t.references :language
			t.references :status
			t.references :environment_type

      			t.timestamps null: false
    		end
  	end
end
