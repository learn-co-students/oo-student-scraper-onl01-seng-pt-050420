require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    x = Nokogiri::HTML(open(index_url))
    cards = x.css('.student-card')
    student_array = []
    cards.each do |card|
      name = card.css('.student-name').text 
      location = card.css('.student-location').text 
      profile_url = card.css('a')[0]["href"]

      student_hash = {}
      student_hash[:name] = name 
      student_hash[:location] = location
      student_hash[:profile_url] = profile_url
      
      student_array << student_hash
      
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    socials = page.css(".social-icon-container")
    info_hash = {}
    socials.each do |social|
      twitter = social.css('a')[0]["href"]
      linkedin = social.css('a')[1]["href"]
      github = social.css('a')[2]["href"]
      blog = social.css('a')[3]["href"]
      
      info_hash[:twitter] = twitter
      info_hash[:linkedin] = linkedin
      info_hash[:github] = github
      info_hash[:blog] = blog
    end
    
    quote = page.css('.profile-quote').text
    bio = page.css('p').text
    
    info_hash[:profile_quote] = quote
    info_hash[:bio] = bio
    return info_hash
    
  end

end


