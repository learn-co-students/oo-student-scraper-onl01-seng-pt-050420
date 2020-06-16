require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").map do |card|
        {name: card.css("h4.student-name").text,
        location: card.css("p.student-location").text,
        profile_url: card.css("a")[0]["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile_data = {}

    quote = doc.css("div.profile-quote").text.strip
    bio = doc.css("p").text.strip

    doc.css("a").each do |link|
      url = link.attribute("href").value
      if url.include?("twitter")
        profile_data[:twitter] = url
      elsif url.include?("github")
        profile_data[:github] = url
      elsif url.include?("linkedin")
        profile_data[:linkedin] = url
      elsif url.match(/^[\/#\.]/) == nil && url.match(/.*facebook.*/i) == nil && url.match(/.*instagram.*/i) == nil
        profile_data[:blog] = url
      end
    end

    if quote != ""
      profile_data[:profile_quote] = quote
    end
    
    if bio != ""
      profile_data[:bio] = bio
    end

    profile_data

  end

end

