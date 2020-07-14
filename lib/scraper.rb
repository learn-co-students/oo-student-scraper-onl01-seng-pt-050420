require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))
    modified_scrape = page.css("div.student-card")
    modified_scrape.each do |student|
      location = student.css("a").map {|link| link['href']}
      student_data = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => location[0]
      }
      students << student_data
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile =  Nokogiri::HTML(open(profile_url))
    social_media = profile.css("div.social-icon-container")
    links = social_media.css("a").map {|link| link['href']}
    student_data = {}
    links.each do |link|
      if link.include?("twitter")
        student_data[:twitter] = link
      elsif link.include?("linked")
        student_data[:linkedin] = link
      elsif link.include?("git")
        student_data[:github] = link
      else
        student_data[:blog] = link
      end
    end
    student_data[:profile_quote] = profile.css(".profile-quote").text
    student_data[:bio] = profile.css("p").text
    student_data
 end
end
