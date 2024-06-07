class CreateApiManagements < ActiveRecord::Migration[7.1]
  def change
    create_table :api_managements do |t|
      t.text :request
      t.text :response
      t.integer :count
      t.time :wait_time
      t.string :comment

      t.timestamps
    end
  end
end
