require 'open-uri'
require 'pry'

# URL: student.css("a").attribute("href").value
#student name : student.css("h4.student-name").text
#location: student.css("p.student-location").text



class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").collect do |student|
      {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      # binding.pry
    end

  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css("div.social-icon-container a").collect { |link|  link.attribute("href").value}

    social_links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    # binding.pry
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css("div.description-holder p").text if doc.css("div.description-holder p")

    student

  end

end