# require 'CSV'
#
# class Generator
#   attr_accessor :word_bank, :crossword
#
#   def initialize(file)
#     @word_bank = []
#
#     CSV.foreach(file) do |row|
#       row.each do |word|
#         @word_bank << word
#       end
#     end
#
#     position_words
#   end
#
#   private
#
#   def random_letter
#     ('a'..'z').to_a[rand(26)]
#   end
# end
