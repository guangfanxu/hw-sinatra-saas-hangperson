class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
    attr_accessor :word
    attr_accessor :guesses
    attr_accessor :wrong_guesses
  
  
  def initialize(word)
    @word = word #.downcase
    @guesses=""
    @wrong_guesses=""
    
  end
  def guess(letter)
    #puts "word=#{word}" 
    if letter.nil? then 
      raise ArgumentError
    end  
    if letter.length==0 then 
      raise ArgumentError
    end  
    if /[^a-zA-Z]/.match(letter) then
      raise ArgumentError
    end  
    wl=word.length
    gl=@guesses.length
    #if wl > 0 then
    #for le in 0..(letter.length -1) do
      for i in 0..(gl -1) do
          #puts "  #{word[i]}"
        if letter.downcase == @guesses[i] then
            return false
        end 
      end    
      if word.length==0 then
        return false
      end  
      for j in 0..(wl -1) do 
          if letter.downcase == word[j].downcase then
              @guesses ="#{@guesses}#{letter.downcase}"
              #word.gsub!(letter.downcase,'-')
              return true
          end
      end    
    wgl=@wrong_guesses.length
    #puts "check @wrong_guesses.length=#{wgl} "
    for i in 0..(wgl -1) do 
          if letter.downcase ==  @wrong_guesses[i]  then
            #puts "#{letter.downcase}==@wrong_guesses=#{@wrong_guesses} goes to wrong list"
            return false
          else 
            #puts "not ==@wrong_guesses=#{@wrong_guesses} goes to wrong list"

          end    
    end
    #puts "letter=#{letter} goes to wrong list"
    #puts "in @wrong_guesses=#{@wrong_guesses} goes to wrong list"
    @wrong_guesses ="#{@wrong_guesses}#{letter.downcase}"
    #puts "after updating wrong guess @wrong_guesses=#{@wrong_guesses}"
    return true
    #else 
    #  return false
    #end
  #end
  end   
  def word_with_guesses
    w=""
    wl=word.length
    gl=@guesses.length
    for i in 0..(wl-1) do
      p=""
      for j in 0..(gl -1) do
        if word[i] == @guesses[j] then
          #puts "word[#{i}] (#{word[i]} should be @guesses[#{j}] #{@guesses[j]} "
          p=" "#word[i]
          w +=word[i]
              #puts w
        end
      end  
      if p =="" then
        w+='-'
     end
    end  
    return w
  end  
  def check_win_or_lose
    if word_with_guesses == word then 
      return :win
    elsif @wrong_guesses.length >=7 then
      return :lose
    else
      return :play
    end
  end  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
