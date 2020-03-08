Rails.application.routes.draw do
  devise_for :admins

  get 'about' => 'home#about'
  get 'resume' => 'home#resume'
  resources 'articles'

  root to: "home#index"
end
