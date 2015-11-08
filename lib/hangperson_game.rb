class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses

  # Get a word from remote "random word" service
  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError, 'Wrong Argument' if letter.nil? || letter.empty? || !letter.match(/[a-zA-Z]/) 
    letter.downcase!
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    @word.include?(letter) ? @guesses << letter : @wrong_guesses << letter
    true
  end
  
  def check_win_or_lose
    if @word == word_with_guesses
      return :win
    elsif @wrong_guesses.size > 6
      return :lose
    else
      return :play
    end
  end
  
  def word_with_guesses
    @word.split('').inject("") do |output, letter|
      @guesses.include?(letter) ? output << letter : output << '-'
      output
    end
  end
  
end
