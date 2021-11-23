require_relative 'study_item.rb'
require_relative 'category.rb'

INSERT       = 1
VIEW_ALL     = 2
SEARCH       = 3
SEARCH_DONE  = 4
EDIT         = 5
DELETE       = 6
EXIT         = 7

def start_screen
  puts <<~MENU
    ***************************************
     [#{INSERT}] Cadastrar um item para estudar   
     [#{VIEW_ALL}] Ver todos os itens cadastrados   
     [#{SEARCH}] Buscar um item de estudo         
     [#{SEARCH_DONE}] Buscar itens concluídos          
     [#{EDIT}] Editar                           
     [#{DELETE}] Apagar                           
     [#{EXIT}] Sair                             
    ***************************************
                        
      Escolha uma opção:   
    MENU
  option = gets.to_i
end


def new_item
  puts "Digite o nome do item de estudo:"

  name = gets.chomp

  puts "Digite uma descrição:"

  description = gets.chomp
  category = Category.new
  new_item = StudyItem.new(name: name, description: description, category: category)
  

  new_item.save_to_db

  puts "#{new_item.name} criado com sucesso!"

end

def list_item
  puts "Itens cadastrados:"
  

  itens = StudyItem.all
  
  itens.each_with_index { |x, i| 
    puts "[#{i + 1}] #{x.name} : #{x.description} => #{x.category}"
  }
end

def delete
  list_item

  puts "Escolha um item para apagar:"

  index = gets.to_i

  itens = StudyItem.all

  name = itens[index - 1].name
  StudyItem.delete_item(name)

  puts "Item apagado com sucesso."

end

def edit
  list_item

  puts "Escolha um item para editar:"

  option = gets.to_i

  puts "
      [1] Editar nome
      [2] Editar descrição
      [3] Editar categoria
      [4] Marcar como concluído"
 
  puts "Escolha uma opção:"

  attribute = gets.to_i

  itens = StudyItem.all
  

  case attribute
  when 1
    puts "Novo nome:"
    new_item = gets.chomp
    StudyItem.update_item("name", new_item, itens[option -1].name)

  when 2
    puts "Nova descrição:"
    new_item = gets.chomp
    StudyItem.update_item("description", new_item, itens[option -1].name)

  when 3
    puts "Nova categoria:"
    new_item = define_category
    StudyItem.update_item("category", new_item, itens[option -1].name)

  when 4
    StudyItem.update_item("completed", "1", itens[option -1].name)
  
  else
    puts "#{attribute} não é uma opção válida."
  end

  puts "Item editado com sucesso."
end

def search_by_category
  itens = StudyItem.all
  itens.each_with_index { |x, i| 
    puts "#{x.category}"
  }
  
  puts "Escolha uma categoria:"

  category = gets.chomp

  categories = StudyItem.find_by_category(category)
  categories.each_with_index { |x, i| 
    puts "[#{i + 1}] #{x.name}, #{x.category}"
  }
end

def list_by_completed
  itens = StudyItem.find_by_completed
  itens.each_with_index { |x, i| 
    puts "[#{i + 1}] #{x.name}, #{x.category}"
  }
end

def search
  puts "Digite o termo para a busca:"
  query = gets.chomp

  itens = StudyItem.find(query)

  if itens.length != 0
    itens.each_with_index { |x, i| 
      puts "[#{i + 1}] #{x.name}, #{x.category}"
    }
  else
    puts "Termo não encontrado"
  end
end

def search_option
  puts "Escolha uma opção de pesquisa:"

  puts "
      [1] Procurar por termo
      [2] Procurar por categoria
      [3] Procurar itens concluídos"
  
  option = gets.to_i
  
  case option 
  when 1
    search
  when 2
    search_by_category
  when 3
    list_by_completed
  else
    print "#{option} não é uma opção válida."
  end
end

puts "Bem-vindo ao Diário de Estudos"
option = 0

while option != 7
  option = start_screen

  case option 
  when INSERT
    new_item
  when VIEW_ALL
    list_item
  when SEARCH
    search_option
  when SEARCH_DONE
    list_by_completed
  when EDIT
    edit
  when DELETE
    delete
  when EXIT
    puts "Finalizando o diário de estudos, volte logo, mantenha a disciplina!!!"
  else
    print "#{option} não é uma opção válida."
  end
end