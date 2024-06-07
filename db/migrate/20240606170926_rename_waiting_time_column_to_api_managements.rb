class RenameWaitingTimeColumnToApiManagements < ActiveRecord::Migration[7.1]
  def change
    rename_column :api_managements, :wait_time, :wtime
  end
end
