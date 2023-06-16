class CreateInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :information do |t|
      t.references :animal, null: false, foreign_key: true
      t.references :sighting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
