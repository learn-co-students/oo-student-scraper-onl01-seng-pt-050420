
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open('https://learn-co-curriculum.github.io/student-scraper-test-page/index.html')
    doc = Nokogiri::HTML(html)
    binding.pry

    students = {}


  end

  def self.scrape_profile_page(profile_url)

  end

end
