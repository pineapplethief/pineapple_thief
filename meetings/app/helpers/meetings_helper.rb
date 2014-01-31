module MeetingsHelper
  def datetimepicker_for(field_id)
    include_datetimepicker_headers_tags
    javascript_tag("$(function() { $('##{field_id}').datetimepicker(datepickerOptions); });")
  end

  def include_datetimepicker_headers_tags
    unless @datetimepicker_headers_tags_included
      @datetimepicker_headers_tags_included = true
      content_for :header_tags do
        start_of_week = Setting.start_of_week
        start_of_week = l(:general_first_day_of_week, :default => '1') if start_of_week.blank?
        # Redmine uses 1..7 (monday..sunday) in settings and locales
        # JQuery uses 0..6 (sunday..saturday), 7 needs to be changed to 0
        start_of_week = start_of_week.to_i % 7

        tags = javascript_tag(
            "var datepickerOptions={dateFormat: 'yy-mm-dd', firstDay: #{start_of_week}, " +
                "showOn: 'button', buttonImageOnly: true, buttonImage: '" +
                path_to_image('/images/calendar.png') +
                "', showButtonPanel: true, showWeek: true, showOtherMonths: true, selectOtherMonths: true};")
        jquery_locale = l('jquery.locale', :default => current_language.to_s)
        unless jquery_locale == 'en'
          tags << javascript_include_tag("i18n/jquery.ui.datepicker-#{jquery_locale}.js")
        end
        tags
      end
    end
  end

end

# Расширяем функциональность встроенной модели redmine без изменения ее исходного кода
module UserPatch
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)

    # добавляем связь с совещаниями типа "многие-ко-многим"
    base.class_eval do
      unloadable
      has_and_belongs_to_many :meetings
    end
  end
end

# Сюда складывать методы класса
module ClassMethods

end

# Сюда складывать методы экземпляров класса
module InstanceMethods

end

User.send(:include, UserPatch)
