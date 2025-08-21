class AddIndexesForReports < ActiveRecord::Migration[8.0]
  def change
    add_index :tweets, :user_id unless index_exists?(:tweets, :user_id)
    add_index :tweets, :created_at unless index_exists?(:tweets, :created_at)
  end
end
