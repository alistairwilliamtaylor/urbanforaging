require 'sinatra'
require 'bcrypt'

require_relative 'db/lib'


if development?
  require 'sinatra/reloader'
  require 'pry'
end

get '/' do

  foods = run_sql("SELECT * FROM food");

  erb :index, locals: {
    foods: foods
  }
end






