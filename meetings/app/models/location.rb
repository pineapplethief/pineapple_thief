# -*- encoding : utf-8 -*-
class Location

  @locations = ["Кабинет начальника отдела",
                "Переговорная № 1",
                "Переговорная № 2",
                "Конференц-зал",
                "Офис отдела",
                "Кабинет директора"]

  def Location.get_locations
    @locations
  end

end