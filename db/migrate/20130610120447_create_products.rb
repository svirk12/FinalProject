class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.float :value
      
      t.timestamps
    end
  end
end
