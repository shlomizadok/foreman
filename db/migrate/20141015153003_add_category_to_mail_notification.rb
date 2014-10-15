class AddCategoryToMailNotification < ActiveRecord::Migration
  def change
    add_column :mail_notifications, :category, :string
  end
end
