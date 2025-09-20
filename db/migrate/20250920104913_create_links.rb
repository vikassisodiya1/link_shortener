# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :original_url, null: false
      t.string :short_code, null: false
      t.integer :clicks, null: false, default: 0

      t.timestamps
    end

    add_index :links, :short_code, unique: true
    add_index :links, :original_url
  end
end
