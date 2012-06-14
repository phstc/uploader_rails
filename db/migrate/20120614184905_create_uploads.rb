class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.text :description
      t.has_attached_file :file
      t.timestamps
    end
  end
end
