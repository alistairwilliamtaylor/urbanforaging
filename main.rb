require 'sinatra'
require 'bcrypt'

if development?
  require 'sinatra/reloader'
  require 'pry'
end

require_relative 'db/lib'

enable(:sessions)

def logged_in?()
  if session[:user_id]
    return true
  else
    return false
  end
end

def current_user
  results = run_sql("SELECT * FROM users WHERE id = $1;", [session[:user_id]])
  return results.first
end


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

post '/sessions' do

  results = run_sql("SELECT * FROM users WHERE email = $1;", [params[:email]])

  if results.count == 1 && my_password = BCrypt::Password.new(results.first['password_digest']).==(params[:password])

    session[:user_id] = results.first['id']

    redirect '/sessions'
  else
    erb :login
  end
end

get '/sessions' do

  user_foods = run_sql("SELECT * FROM food WHERE user_id = $1", [current_user['id']])
  
  erb :sessions, locals: {
    user_foods: user_foods
  }
end

delete '/sessions' do
  session[:user_id] = nil
  redirect '/'
end