class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word ,:guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError, "Invalid guess: empty" if letter.nil? || letter.empty?
    letter.downcase!
    raise ArgumentError, "Invalid guess: not a letter" unless letter.match?(/[a-z]/)

    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end

    if @word.include?(letter)
      @guesses += letter
      return true
    else
      @wrong_guesses += letter
      return true
    end
  end

  def word_with_guesses
    display_word = @word.chars.map do |char|
      if @guesses.include?(char)
        char
      else
        '-'
      end
    end
    display_word.join
  end

  def check_win_or_lose
    return :win if @word.chars.all? { |char| @guesses.include?(char) }
    return :lose if @wrong_guesses.length >= 7
    :play
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
