class Slot
  attr_reader :coin, :point
  
  HOEIZONRAL_LINE_LIST = ["上横", "真ん中", "下横"]
  DIAGONAL_LINE_LIST = ["左上", "右上"]
  REEL_LEFT = 0
  REEL_CENTER = 1
  REEL_RIGHT = 2
  REEL_TOP = 0
  REEL_MIDDLE = 1
  REEL_BOTTOM = 2
  REEL_NUM = 3
  
  def initialize(coin, earnRate, returnRate)
    @coin = coin
    @point = 0
    @earnRate = earnRate
    @returnRate = returnRate
  end
  
  def can_bet?(coin)
    @coin >= coin
  end
  
  def game_start(bet)
    @coin -= bet
    alignedLine = slot_execution
    calculate_points_earned(bet, alignedLine)
    calculate_coins_earned(bet, alignedLine)
  end
  
  private
  
  def slot_execution
    puts "エンターを3回押しましょう！"
    reel = Array.new(REEL_NUM) { Array.new(HOEIZONRAL_LINE_LIST.length, nil) }
    
    for i in 0...HOEIZONRAL_LINE_LIST.length do
      gets
      puts "------------"
      
      for j in 0...REEL_NUM do
        reel[j][i] = rand(1..9)
      end
      display_reel(reel)
    end
    
    puts "------------"
    
    alignedLine = is_horizonatal_line_aligned?(reel)
    alignedLine += diagonal_line_aligned?(reel)
  end
  
  def display_reel(reel)
    for i in 0...reel.length do
      text = "|"
      for j in 0...reel[i].length do
        text << reel[i][j].to_s unless reel[i][j].nil?
        text << "|"
      end
      puts text
    end
  end
  
  def is_horizonatal_line_aligned?(reel)
    alignedLine = 0
    
    for i in 0...reel.length do
      median = reel[i][REEL_CENTER]
      
      if [reel[i][REEL_LEFT], median, reel[i][REEL_RIGHT]].uniq.length == 1
        notify_that_numeric_aligned(HOEIZONRAL_LINE_LIST[i], median)
        alignedLine += 1
      end
    end
    
    alignedLine
  end
  
  def diagonal_line_aligned?(reel)
    alignedLine = 0
    median = reel[REEL_CENTER][REEL_MIDDLE]
    
    if [reel[REEL_LEFT][REEL_TOP], median, reel[REEL_RIGHT][REEL_BOTTOM]].uniq.length == 1
      notify_that_numeric_aligned(DIAGONAL_LINE_LIST[0], median)
      alignedLine += 1
    end
    
    if [reel[REEL_LEFT][REEL_BOTTOM], median, reel[REEL_RIGHT][REEL_TOP]].uniq.length == 1
      notify_that_numeric_aligned(DIAGONAL_LINE_LIST[1], median)
      alignedLine += 1
    end
    
    alignedLine
  end
  
  def notify_that_numeric_aligned(line, target)
    puts "#{line}に#{target.to_s}が揃いました！"
  end
  
  def calculate_points_earned(bet, alignedLine)
    if alignedLine > 0
      earnedPoints = bet * @earnRate * alignedLine
      
      puts "#{earnedPoints}ポイント獲得！"
      @point += earnedPoints
    end
  end
  
  def calculate_coins_earned(bet, alignedLine)
    if alignedLine > 0
      earnedCoins = bet * @returnRate * alignedLine
      
      puts "#{earnedCoins}コイン獲得！"
      @coin += earnedCoins
    end
  end
end
