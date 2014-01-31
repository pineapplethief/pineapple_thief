# -*- encoding : utf-8 -*-
class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|

      t.string :topic

      t.string :location

      t.string :description

      t.string :results

      t.datetime :start

      t.datetime :end

    end

  end
end
