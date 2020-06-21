require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    student_cards = doc.css(".student-card")
    student_cards.each do |card|
      scraped_student = {}
      name = card.css(".student-name").text
      location = card.css(".student-location").text
      profile_url = card.children.css("a")[0]['href']
      scraped_student[:name] = name
      scraped_student[:location] = location
      scraped_student[:profile_url] = profile_url
      students << scraped_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    student_profile[:twitter] = doc.css(".social-icon-container").children.css("a")[0]['href'] || nil
    student_profile[:linkedin] = doc.css(".social-icon-container").children.css("a")[1]['href'] || nil
    student_profile[:github] = doc.css(".social-icon-container").children.css("a")[2]['href'] || nil
    student_profile[:blog] = doc.css(".social-icon-container").children.css("a")[3]['href'] || nil
    student_profile[:bio] = doc.css(".description-holder").children.css("p").text || nil
    student_profile[:profile_quote] = doc.css(".profile-quote").text || nil
    student_profile
  end

end


# doc = Nokogiri::HTML(open('https://learn-co-curriculum.github.io/student-scraper-test-page/students/joe-burgess.html'))

# print doc.css(".description-holder").children.css("p").text
