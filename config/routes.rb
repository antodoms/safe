Rails.application.routes.draw do

  devise_for :users
  root to: 'employees#home'

  get '/home' , to: 'employees#home', as: 'home'
  get '/employees/getdata', to: 'employees#getdata'
  get '/employees' , to: 'employees#index'

 resources :employees
  
end
