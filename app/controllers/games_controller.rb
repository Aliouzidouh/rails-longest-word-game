require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @word = Array.new(10) { ('A'..'Z').to_a.sample }
    @letters = @word.join(" ")
  end

  def score

    if included?(params[:reponse].upcase, params[:word])
      if english_word?(params[:reponse])
        @resultat = "well done"
      else
        @resultat = "not an english word"
      end
    else
      @resultat = "not in the grid"
    end
  end

  def included?(guess, word)
    guess.chars.all? { |letter| guess.count(letter) <= word.count(letter) }
  end

  def english_word?(guess)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{guess}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
