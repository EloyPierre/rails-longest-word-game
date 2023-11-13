require "open-uri"
require "json"
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:score]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    found_value = JSON.parse(word_serialized)['found']

    if result?(@word, @letters) == false
      @answer = "Sorry but #{@word} can't be built out of #{@letters}"
    elsif found_value == false
      @answer = "Sorry but #{@word} does not seem to be a valid English word"
    else
      @answer = "Congratulations! #{@word} is a valid English word !"
    end
  end

  def result?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
