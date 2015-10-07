class AddAttachmentImageToCasts < ActiveRecord::Migration
  def self.up
    change_table :casts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :casts, :image
  end
end
