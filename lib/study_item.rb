require 'sqlite3'
require_relative 'category.rb'

class StudyItem
  attr_accessor :name, :category, :description, :completed

  def initialize(name:, category: Category.new(), description:, completed: 0)
    @name = name
    @category = category
    @description = description
    @completed = completed
  end

  def self.all
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    itens = db.execute "SELECT name, description, category, completed FROM itens"
    db.close
    itens.map { |x| new(name: x["name"], description: x["description"], category: x["category"], completed: x["completed"]) }
  end

  def save_to_db
    db = SQLite3::Database.open "db/database.db"
    db.execute "INSERT INTO itens VALUES('#{name}', '#{description}', '#{category.name}', '#{completed}')"
    db.close
    self
  end

  def self.delete_item(name)
    db = SQLite3::Database.open "db/database.db"
    db.execute "DELETE FROM itens WHERE name = '#{name}'"
    db.close
  end

  def self.update_item(attribute, new_item, name)
    db = SQLite3::Database.open "db/database.db"
    db.execute "UPDATE itens SET '#{attribute}' = '#{new_item}' WHERE name = '#{name}'"
    db.close
  end

  def self.find(query)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    itens = db.execute "SELECT name, description, category, completed FROM itens where name LIKE '#{query}%' OR description LIKE '%#{query}%'"
    db.close
    itens.map { |x| new(name: x["name"], description: x["description"], category: x["category"], completed: x["completed"]) }
  end

  def self.find_by_category(category)
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    itens = db.execute "SELECT name, description, category, completed FROM itens where category='#{category}'"
    db.close
    itens.map { |x| new(name: x["name"], description: x["description"], category: x["category"], completed: x["completed"]) }
  end

  def self.find_by_completed
    db = SQLite3::Database.open "db/database.db"
    db.results_as_hash = true
    itens = db.execute "SELECT name, description, category, completed FROM itens where completed='1'"
    db.close
    itens.map { |x| new(name: x["name"], description: x["description"], category: x["category"], completed: x["completed"]) }
  end
end