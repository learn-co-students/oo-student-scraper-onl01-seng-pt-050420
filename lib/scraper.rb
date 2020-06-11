
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
      students = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students_array << students
    end
    students_array
  end

  # profile anchors: document.css("div.social-icon-container > a")
  # profile quote: document.css("div.profile_quote").text
  # bio: document.css("div.description-holder p").text


  def self.scrape_profile_page(profile_url)
    html = profile_url
    document = Nokogiri::HTML(open(html))
    student_profiles = {}
    profile_social_links = document.css("div.social-icon-container > a").map { |profile_social_link|
      profile_social_link.attribute("href").value
    }.each do |social_link|
      if social_link.include?("twitter")
        student_profiles[:twitter] = social_link
      elsif social_link.include?("linkedin")
        student_profiles[:linkedin] = social_link
      elsif social_link.include?("github")
        student_profiles[:github] = social_link
      else
        student_profiles[:blog] = social_link
      end
    end
    student_profiles[:profile_quote] = document.css("div.profile-quote").text
    student_profiles[:bio] = document.css("div.description-holder p").text
    student_profiles
    # binding.pry
  end

end
