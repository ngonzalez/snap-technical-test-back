class CreateCsvExports < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_exports do |t|
      t.references :user, index: true
      t.string :file_uid
      t.string :file_name

      t.timestamps
    end
  end
end
