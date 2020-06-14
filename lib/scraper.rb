require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    student_arr = []
    students.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attr("href").text
      hash = {name: name, location: location, profile_url: profile_url}
      student_arr << hash
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    # binding.pry
    doc = Nokogiri::HTML(open(profile_url))
    social_link = doc.css(".vitals-container .social-icon-container a")
    student_hash = {}
    social_link.each do |element|
      if element.attr("href").include?("twitter")
        student_hash[:twitter] = element.attr("href")
      elsif element.attr("href").include?("linkedin")
        student_hash[:linkedin] = element.attr("href")
      elsif element.attr("href").include?("github")
        student_hash[:github] = element.attr("href")
      else
        student_hash[:blog] = element.attr("href")
      end
    end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text
    student_hash
  end
  
end

