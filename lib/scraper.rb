require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("#{index_url}"))
    students = doc.css("div.student-card")
    student_info = []

    students.collect do |student|
      student_info << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end

    student_info
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))
    vitals = doc.css(".vitals-container")
    details = doc.css(".details-container")
    student = vitals.css(".profile-name").text.gsub(" ","_").downcase.to_sym
    student_profile = {}
    # student_profile[student] = {}
    remove_path = "../assets/img/"
    remove_file_extension = "-icon.png"

    #Handles social info if provided
    vitals.css(".social-icon-container a").each do |social|
      if social.css("img.social-icon").attr("src").value.gsub("#{remove_path}","").gsub("#{remove_file_extension}","") == "rss"
        student_profile[:blog] = social.attr("href")
      else
        student_profile[social.css("img.social-icon").attr("src").value.gsub("#{remove_path}","").gsub("#{remove_file_extension}","").to_sym] = social.attr("href")
      end
    end
    student_profile[:profile_quote] = vitals.css(".profile-quote").text
    student_profile[:bio] = details.css("div.bio-content.content-holder div.description-holder p").text
    student_profile
  end

end

