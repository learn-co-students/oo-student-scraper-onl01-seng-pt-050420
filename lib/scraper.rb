require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_arr = []
    
    doc.css(".student-card").each do |student|
      new_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      student_arr << new_hash
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css(".social-icon-container").css("a").each do |social|
      if social.attribute("href").value.include?("linkedin")
        student[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("twitter")
      student[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
      student[:github] = social.attribute("href").value
      else student[:blog] = social.attribute("href").value
      end
    end
  student[:profile_quote] = doc.css(".profile-quote").text
  student[:bio] = doc.css(".description-holder").css("p").text
  student
  end

end


