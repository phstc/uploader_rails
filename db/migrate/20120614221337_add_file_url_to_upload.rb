class AddFileUrlToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :file_url, :string
  end
end
