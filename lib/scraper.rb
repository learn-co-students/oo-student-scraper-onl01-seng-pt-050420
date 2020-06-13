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
        student_list[:profile_url] = profile.css("a").attribute("href").value
        index_page << student_list
    end
    index_page
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    
    doc = Nokogiri::HTML(open(profile_url))
    #binding.pry

    doc.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else 
        student_profile[:blog] = social.attribute("href").value
      end 
    end 

    student_profile[:profile_quote] = doc.css("div.profile-quote").text
    student_profile[:bio] = doc.css("div.bio-block.details-block div.description-holder").text.strip
    student_profile
  end
  
end

