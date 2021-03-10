require 'bcrypt'
require 'pg'
require_relative 'lib'

email = 'alistairwilliamtaylor@gmail.com'
password = 'pudding'

password_digest = BCrypt::Password.create("pudding")

run_sql("INSERT INTO users (email, password_digest) VALUES ($1, $2);", [email, password_digest])
