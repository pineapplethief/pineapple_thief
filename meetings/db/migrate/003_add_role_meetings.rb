# -*- encoding : utf-8 -*-
class AddRoleMeetings < ActiveRecord::Migration
  # model removed
  class Role < ActiveRecord::Base; end

  # Роль для управления совещаниями (см. последнюю строчку :permissions)
  def self.up
    Role.create! :name => l(:role_meetings_manager),
                          :position => 4,
                          :permissions => [:view_issues,
                                           :add_issues,
                                           :add_issue_notes,
                                           :save_queries,
                                           :view_gantt,
                                           :view_calendar,
                                           :log_time,
                                           :view_time_entries,
                                           :comment_news,
                                           :view_documents,
                                           :view_wiki_pages,
                                           :view_wiki_edits,
                                           :add_messages,
                                           :edit_own_messages,
                                           :view_files,
                                           :browse_repository,
                                           :view_changesets,
                                           :create_meetings]
  end

  def self.down
    Role.where("name=?", l(:role_meetings_manager)).first.destroy
  end
end