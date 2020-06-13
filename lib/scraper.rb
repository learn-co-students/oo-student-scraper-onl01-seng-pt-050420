require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    index_page = []
    doc.css("div.student-card").each do |profile|
        student_list = {}
        student_list[:name] = profile.css("h4.student-name").text
        student_list[:location] = profile.css("p.student-location").text
        profile_path = profile.css("a").attribute("href").value
        student_list[:profile_url] = profile_path
        index_page << student_list
    end
    index_page
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

