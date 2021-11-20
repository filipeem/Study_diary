require 'sqlite3'
require_relative 'study_item.rb'

class Category
  attr_accessor :name

  def initialize()
    puts "
      [1] Ruby
      [2] Javascript
      [3] Python
      [4] Java"
  
    puts "Escolha uma categoria para seu item de estudo:"
  
    category = gets.chomp.to_i
    
    case category
    when 1
    @name = "Ruby" 
    when 2
    @name = "Javascript"
    when 3
    @name = "Python"
    when 4
    @name = "Java"
    else
     puts "#{category} não é uma opção válida."
    end
  end

  
end