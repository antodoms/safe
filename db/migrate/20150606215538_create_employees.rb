class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
    	t.string :handle, :name
    	t.integer :employer
    end
  end
end
