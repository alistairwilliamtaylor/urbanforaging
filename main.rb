require 'sinatra'
require 'bcrypt'

if development?
  require 'sinatra/reloader'
  require 'pry'
end

require_relative 'db/lib'

enable(:sessions)


get '/' do

  foods = run_sql("SELECT * FROM food");

  erb :index, locals: {
    foods: foods
  }
end

get '/about' do
  erb :about
end

get '/foods/new' do
  erb :new_food
end

post '/foods' do

  run_sql("INSERT INTO food(food_type, image_url, location_description) VALUES($1, $2, $3);", 
  [
    params[:food_type],
    params[:image_url],
    params[:location_description]
  ])

  redirect '/'
end

get '/login' do
  erb :login
end





