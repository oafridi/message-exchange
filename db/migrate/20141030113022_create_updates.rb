class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :body
      t.belongs_to :user

      t.timestamps
    end
  end
end
