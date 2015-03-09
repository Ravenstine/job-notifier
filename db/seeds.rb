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
Board.create name: "Craigslist"


Location.create city: "Los Angeles", county: "Los Angeles", state: "CA", country: "US", zip_code: "90001", craigslist_prefix: "losangeles"
Location.create city: "San Francisco", county: "San Francisco", state: "CA", country: "US", zip_code: "94101", craigslist_prefix: "sfbay"
Location.create city: "Santa Barbara", county: "Santa Barbara", state: "CA", country: "US", zip_code: "93101", craigslist_prefix: "santabarbara"

Agent.create terms: "ruby", location_id: 1
Agent.create terms: "ruby", location_id: 2