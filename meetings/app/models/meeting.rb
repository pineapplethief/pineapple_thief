# -*- encoding : utf-8 -*-
class Meeting < ActiveRecord::Base
  include ActiveModel::Validations

  unloadable

  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users
  has_many :attachments

  acts_as_attachable

  validates :topic, :presence => true
  validates :location, :presence => true
  validates :description, :presence => true
  validates_length_of :topic, :minimum => 5, :maximum => 55
  validates :start, :presence => true
  validates :end, :presence => true

  validate :dates_are_correct
  validate :no_more_meetings_in_this_room
  validate :users_not_empty
  validate :people_are_way_too_busy

  def proper_datetime
    errors.add(:base, 'must be a valid datetime') if ((DateTime.parse(self.start) rescue ArgumentError) == ArgumentError)
    errors.add(:base, 'must be a valid datetime') if ((DateTime.parse(self.end) rescue ArgumentError) == ArgumentError)
  end

  def dates_are_correct
    if (self.start.blank? or self.end.blank?)
      return
    end
    diff = self.end - self.start
    errors.add(:base, l(:validation_error_dates_are_wrong)) unless
        diff > 0
  end

  def no_more_meetings_in_this_room
    if (self.start.blank? or self.end.blank?)
      return
    end

    meetings = Meeting.where("location = ?", self.location)
    meetings.each do |meeting|
      if meeting.start < self.end and meeting.start > self.start or
         meeting.end > self.start and meeting.start < self.start
        errors.add(:base, l(:validation_error_location_busy))
        return
      end
    end
  end

  def people_are_way_too_busy
    user_ids = self.users.map {|user| user.id}
    meetings = Meeting.joins(:users).where("user_id IN (?)", user_ids)
    meetings.each do |meeting|
      if meeting.start < self.end and meeting.start > self.start or
          meeting.end > self.start and meeting.start < self.start
        errors.add(:base, l(:validation_error_user_busy))
      end
    end
  end

  def users_not_empty
    if users.empty? then errors.add(:base, l(:validation_error_no_users))
    end
  end

end
