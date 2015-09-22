class RemoveChefProxy < ActiveRecord::Migration
  def up
    chef_feature = Feature.delete_all("name = 'Chef Proxy'")
  end

  def down
    Feature.where(:name => "Chef Proxy").first_or_create!
  end
end
