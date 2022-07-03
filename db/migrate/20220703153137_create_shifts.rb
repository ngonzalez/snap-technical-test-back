class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|

      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
