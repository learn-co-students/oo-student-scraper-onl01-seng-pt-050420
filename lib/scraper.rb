
require 'open-uri'
require 'pry'

class Scraper

  # students: doc.css("div.student-card")
  # name: students.css("h4.student-name").text
  # location: students.css("p.student-location").text
  # profile_url: students.css("a").attribute("href").value

  def self.scrape_index_page(index_url)
    html = index_url
    document = Nokogiri::HTML(open(html))
    # binding.pry

    students_array = []

    #iterate through the students hash
    document.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      students = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students_array << students
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)

  end

end
