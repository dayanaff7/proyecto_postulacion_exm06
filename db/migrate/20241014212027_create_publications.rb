class CreatePublications < ActiveRecord::Migration[7.2]
  def change
    create_table :publications do |t|
      t.string :cargo
      t.string :description

      t.timestamps
    end
  end
end
