# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
EMAILS = ['marshal@kalynchuk.ca', 'john@gmail.com', 'kali@outlook.ca']
PASSWORD = 'password'
EMAILS.each do |email| 
  user = User.create(email: email, password: PASSWORD, password_confirmation: PASSWORD)
  user.confirm 
end
