require './slot.rb'

bet_list = [10, 30, 50]

def get_choice(choice_list, length)
  choice = nil
  
  loop {
    begin
      puts choice_list
      puts "-------"
      choice = gets.chomp.to_i
      break if choice > 0 && choice <= length
    rescue
    end
  }
  
  choice
end

slot = Slot.new(100, 10, 2)

loop {
  puts "-------"
  puts "残りコイン数 #{slot.coin}"
  puts "ポイント #{slot.point}"
  puts "何コイン入れますか？"
  
  i = 1
  choice_list = "";
  
  for j in 0...bet_list.length do
    (choice_list << "#{i}(#{bet_list[j]}コイン） "; i += 1) if slot.can_bet?(bet_list[j])
  end
  
  choice_list << "#{i}(やめとく）"
  
  choice = get_choice(choice_list, i)
  return if choice == i
  
  slot.game_start(bet_list[choice - 1])
}
