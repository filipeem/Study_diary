require 'sqlite3'

class Category
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def self.choose_category
    categories = ['Ruby', 'Javascript', 'Python', 'Java']
    categories.each_with_index { |x, i| 
      puts "[#{i + 1}] #{x}"}
    puts "Escolha uma categoria para seu item de estudo:"
  
    category = gets.to_i
    
    if category > categories.length
     puts "#{category} não é uma opção válida."
    else
     new(categories[category-1])
    end
  end

  
end