require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10).map { ('A'..'Z').to_a.sample }
  end

  def score
    @attempt = params[:word].strip.upcase
    @url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    @word_hash = JSON.parse(URI.open(@url).read)
    @message = 'the given word is not in the grid'
    @attempt_split = @attempt.chars
    @letterzz = @attempt_split.map do |letter|
      if !letter.match(/[#{params[:letters]}.join]/).nil? && @attempt_split.count(letter) <= params[:letters].count(letter)
        'OK'
      else
        'NOK'
      end
    end
    unless @letterzz.include?('NOK')
      if @word_hash['found'] == false
        @message = 'the given word is not an english word'
      else
        @message = 'Well done!'
      end
    end
  end
end
