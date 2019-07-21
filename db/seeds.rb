require 'date'
require 'faker'
I18n.reload!

# USERS
puts "-> Delete existing users"
User.delete_all

puts "-> Create 20 users"
20.times do |n|
	email = "user_#{n}@immomatic.co"
	password = "usermatic-#{n}"
	User.create!(
		email: email,
		password: password
		)
end

# REAL_ESTATE
puts "-> Delete existing real_estates"
RealEstate.delete_all

puts "-> 50 real_estates for each users"
20.times do |user|
	user = User.find(user + 1)
	50.times do |re|
		real_estate = RealEstate.create!(
			ad_link: Faker::Internet.url,
			buying_price: rand(50000..200000),
			monthly_rent_estimation: rand(400..1500),
			annual_charges: rand(500..2000),
			state: RealEstate::STATES.sample,
			address_street: Faker::Address.street_address,
			postal_code: Faker::Address.zip_code,
			city: Faker::Address.city,
			country: Faker::Address.country,
			user: user)
	end
end