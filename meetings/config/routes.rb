# -*- encoding : utf-8 -*-
# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'meetings' => 'meetings#index'
get 'meetings/create' => 'meetings#create', :as => :meeting
get 'meetings/:id' => 'meetings#show'

post 'meetings/create' => 'meetings#create', :as => :meeting

# match 'meetings/create', :to => 'meetings#create', :as => :meeting