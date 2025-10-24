# db/seeds.rb
require "faker"

# Clear existing data
User.destroy_all
Deck.destroy_all
Card.destroy_all

# Create a user
user = User.create!(
  email_address: "test@test.com",
  password: "password"
)

# Create an HSK 1 Verbs deck
deck = Deck.create!(
  name: "HSK 1 Verbs",
  description: "HSK 1 Verb flashcards",
  user: user
)

# HSK 1 verbs data (20 examples)
hsk1_verbs = [
  { hanzi: "是", pinyin: "shì", english: "to be" },
  { hanzi: "有", pinyin: "yǒu", english: "to have" },
  { hanzi: "去", pinyin: "qù", english: "to go" },
  { hanzi: "来", pinyin: "lái", english: "to come" },
  { hanzi: "吃", pinyin: "chī", english: "to eat" },
  { hanzi: "喝", pinyin: "hē", english: "to drink" },
  { hanzi: "看", pinyin: "kàn", english: "to see / to watch" },
  { hanzi: "听", pinyin: "tīng", english: "to listen" },
  { hanzi: "说", pinyin: "shuō", english: "to speak" },
  { hanzi: "做", pinyin: "zuò", english: "to do / to make" },
  { hanzi: "买", pinyin: "mǎi", english: "to buy" },
  { hanzi: "卖", pinyin: "mài", english: "to sell" },
  { hanzi: "坐", pinyin: "zuò", english: "to sit" },
  { hanzi: "住", pinyin: "zhù", english: "to live / to stay" },
  { hanzi: "写", pinyin: "xiě", english: "to write" },
  { hanzi: "读", pinyin: "dú", english: "to read" },
  { hanzi: "学", pinyin: "xué", english: "to study" },
  { hanzi: "喜欢", pinyin: "xǐ huan", english: "to like" },
  { hanzi: "认识", pinyin: "rèn shi", english: "to know (someone)" },
  { hanzi: "叫", pinyin: "jiào", english: "to be called / to call" }
]

# Create the cards
hsk1_verbs.each do |verb|
  deck.cards.create!(
    front: "#{verb[:hanzi]} (#{verb[:pinyin]})",
    back: verb[:english]
  )
end

puts "✅ Seeded #{User.count} user, #{Deck.count} deck, and #{Card.count} cards."
puts "Demo user: test@test.com / password"
