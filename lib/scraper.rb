require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    roster = page.css(".roster-cards-container")
    
    students = []
    
    roster.each do |student|
      student.css(".student-card a").each do |info|
        name = info.css(".student-name").text
        location = info.css(".student-location").text
        link = "#{info.attribute('href').value}"
        
    # name = roster.css(".student-name").first.text.strip
    # location = roster.css("student-location").first.text.strip
    # profile_url = roster.css(".student-card a").attribute('href').value
    
        students << {name: name, location: location, profile_url: link} 
            #pushing new key/value pairs into an array
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    social_links = profile.css(".social-icon-container a").map { |link| link['href']}

    links = {}

    social_links.each do |url|
      if url.include?("twitter")
        links[:twitter] = url 
      elsif url.include?("linkedin")
        links[:linkedin] = url 
      elsif url.include?("github")
        links[:github] = url
      else
        links[:blog] = url
      end
    end
    
    links[:profile_quote] = profile.css(".vitals-text-container").css(".profile-quote").text.strip
    links[:bio] = profile.css(".description-holder p").text
    
    links
  end

end

