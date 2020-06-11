require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.map do |key, value|
      self.send(("#{key}="), value)
      @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students_array.map do |student_hash|
      self.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.map do |attribute, value|
      self.send(("#{attribute}="), value)
    end
  end

  def self.all
    @@all
  end

end
