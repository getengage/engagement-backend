# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

client = Client.where(name: "FooCompany").first_or_create
user.update(client: client)
puts 'CREATED CLIENT: ' << client.name

api_key = ApiKey.where(name: "test").first_or_create
ClientApiKey.where(client: client, api_key: api_key).first_or_create
puts 'CREATED API KEY: ' << api_key.name
