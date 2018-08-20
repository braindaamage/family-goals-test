class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :world
      t.string :area
      t.string :position
    end
  end
end
