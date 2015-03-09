# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Board.create name: "Stack Overflow Careers"
Board.create name: "GitHub Jobs"
Board.create name: "Authentic Jobs"

Location.create city: "Los Angeles", county: "Los Angeles", state: "CA", zip_code: "90001"
Location.create city: "San Francisco", county: "San Francisco", state: "CA", zip_code: "94101"
Location.create city: "Santa Barbara", county: "Santa Barbara", state: "CA", zip_code: "93101"