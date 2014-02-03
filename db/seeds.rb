# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

Word.delete_all

words = []
("a".."z").to_a.each do |letter|

  url = "http://phrontistery.info/#{letter}.html"
  doc = Nokogiri::HTML(open(url))
  found_trs = doc.css(".words").css('tr')

  parsed_tr = found_trs.map do |tr|
    word, definition = tr.css('td')
    if word && definition
      word_without_comma = word.text.chomp.gsub(",","")
      Word.create(name: word_without_comma, definition: definition.text.chomp)
    end
  end
end
