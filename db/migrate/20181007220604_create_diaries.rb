class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :user_id, limit: 36, null: false, default: ''
      t.text :body, null: false
      t.integer :negaposi, null: false, default: 0

      t.timestamps
    end
    add_index :diaries, :user_id
    add_index :diaries, :created_at
  end
end
