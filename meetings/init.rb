# -*- encoding : utf-8 -*-
Redmine::Plugin.register :meetings do
  name 'Meetings plugin'
  author 'Alexey Glukhov'
  description 'Тестовое задание на соискание вакансии Ruby-программиста в Монастыреве'
  version '0.0.1'

  # Добавляем новый пункт в меню
  menu :top_menu , :meetings, {:controller => 'meetings', :action => 'index' }, :caption => :label_meeting

  # Создаем права на создание совещаний
  permission :create_meetings, :meetings => :create

end
