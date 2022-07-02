class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.references :user

      t.datetime :starts_at
      t.datetime :ends_at

      t.datetime :real_starts_at
      t.datetime :real_ends_at

      t.datetime :locked_at

      t.timestamps
    end
  end
end
