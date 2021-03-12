require 'sinatra'
require 'bcrypt'
require 'active_support'
require 'action_view'
require 'cloudinary'
require_relative 'db/lib'

include CloudinaryHelper


if development?
  require 'sinatra/reloader'
  require 'pry'
end



auth = {
  cloud_name: 'dmavnywma',
  api_key: ENV['cloudinary_api_key'],
  api_secret: ENV['cloudinary_secret_api_key']
}

sydney_regions = ['St George', 'Inner West', 'City Center', 'South Western Sydney', 'Greater Western Sydney', 'Hills District', 'Sutherland Shire', 'Eastern Suburbs', 'Northern Beaches', 'North Shore'].sort

culinary_categories = ['fruit', 'herb', 'vegetable', 'funghi'].sort



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
  if logged_in?
    erb :new_food
  else redirect '/login'
  end
end

post '/foods' do

  if logged_in?
    result = Cloudinary::Uploader.upload(params[:image][:tempfile], auth)

    run_sql("INSERT INTO food(food_type, image_url, location_description, user_id) VALUES($1, $2, $3, $4);", 
    [
      params[:food_type],
      result['url'],
      params[:location_description],
      current_user['id']
    ])

    redirect '/sessions'
  else
    redirect '/login'
  end
end

get '/foods' do
  food = run_sql("SELECT * FROM food WHERE id = #{params[:id]}")[0]

  erb :food_details, locals: {
    food: food
  } 
end

delete '/foods' do
  food_creator_hash = run_sql("SELECT user_id FROM food WHERE id = $1;", [params[:food_id]])

  food_creator_id = food_creator_hash.first['user_id']

  if food_creator_id == current_user['id']
    run_sql("DELETE FROM food WHERE id = $1", [params[:food_id]])
    redirect '/sessions'
  else
    redirect '/'
  end
end

get '/foods/edit' do
  food = run_sql("SELECT * FROM food WHERE id = $1", [params[:food_id]]).first

  erb :edit_food, locals: {
    food: food
  }
end

patch '/foods' do
  food_creator_hash = run_sql("SELECT user_id FROM food WHERE id = $1;", [params[:food_id]])

  food_creator_id = food_creator_hash.first['user_id']

  if food_creator_id == current_user['id']
    run_sql("UPDATE food SET food_type = $1, location_description = $2 WHERE id = $3", 
      [
        params[:food_type],
        params[:location_description],
        params[:food_id]
      ])
    redirect '/sessions'
  else
    redirect '/'
  end  
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

get '/sessions/new' do
  erb :new_user
end

post '/sessions/new' do
  existing_user = run_sql("SELECT * FROM users WHERE email = $1", [params[:email]])

  if existing_user.count == 0
    password_digest = BCrypt::Password.create(params[:password])
    run_sql("INSERT INTO users (email, password_digest) VALUES ($1, $2);", [params[:email], password_digest])
    results = run_sql("SELECT * FROM users WHERE email = $1;", [params[:email]])
    session[:user_id] = results.first['id']
    redirect '/sessions'
  else
    redirect '/sessions/new'
  end
end

get '/search' do
  erb :search
end