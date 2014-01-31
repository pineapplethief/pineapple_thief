# -*- encoding : utf-8 -*-
class CreateMeetingsUsers < ActiveRecord::Migration
  def self.up
    create_table :meetings_users, :id => false do |t|
      t.references :meeting
      t.references :user
    end
    add_index :meetings_users, [:meeting_id, :user_id]
    add_index :meetings_users, :user_id
  end

  def self.down
    drop_table :meetings_users
  end
end
