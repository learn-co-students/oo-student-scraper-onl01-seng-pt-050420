require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    url = open(index_url)
    doc = Nokogiri::HTML(url)
    card = doc.css(".student-card a")
    card.each do |info|
      student_name = info.css(".student-name").text 
      student_location = info.css(".student-location").text
      student_profile_url = info.attr('href')
      students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end 
    students
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    url = open(profile_url)
    doc = Nokogiri::HTML(url)
    
    profiles = doc.css(".social-icon-container a")
    
    profiles.each do |info|
      if info.attr('href').include?("twitter")
          hash[:twitter] = info.attr('href')
        elsif info.attr('href').include?("linkedin")
          hash[:linkedin] = info.attr('href')
        elsif info.attr('href').include?("github")
          hash[:github] = info.attr('href')
        elsif info.attr('href').end_with?("com/")
          hash[:blog] = info.attr('href')
        end
      end
    hash[:profile_quote] = doc.css(".profile-quote").text 
    hash[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    
    hash
  end

end

