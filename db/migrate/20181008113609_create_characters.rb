class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :user_id, limit: 36, null: false, default: ''
      t.references :diary, null: false, unique: true, foreign_key: true
      t.string :name, limit: 191, null: false, default: ''

      t.timestamps
    end
    add_index :characters, [:user_id, :name]
    # add_foreign_key :characters, :diaries
  end
end
