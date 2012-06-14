class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.text :description
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.date :file_updated_at
      t.timestamps
    end
  end
end
