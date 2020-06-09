class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student = {}
    student_hash.each do |k,v| 
      self.send("#{k}=","#{v}")
    end
    @@all << self
    student 
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student) unless Student.all.include?(student[:name])
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      self.send("#{k}=",v)
    end
  end

  def self.all
    @@all
  end
end

