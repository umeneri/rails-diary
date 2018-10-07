class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :user_id
      t.text :body
      t.integer :negaposi

      t.timestamps
      t.index :user_id
    end
  end
end
