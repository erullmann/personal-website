admin = Admin.create(email: 'testadmin@rullmann.ca', password: 'Testing123', password_confirmation: 'Testing123')

emoji = %w[🤠 😁 👨‍💻 🖖 👋 🧵 👑 🙏]

# have to do this because Faker has bug with inserting tables
def makdown_sandwich(sentences: 3, repeat: 1)
  text_block = []
  repeat.times do
    text_block << Faker::Lorem.sentences(number: sentences)
    text_block << "\n" + Faker::Markdown.random
  end
  text_block.join("\n")
end

(1..50).each do |index|
  Article.create(skip_date_validation: true, admin: admin, title: Faker::Lorem.sentence, body: makdown_sandwich(sentences: (5 * rand + 1).to_i, repeat: (3 * rand + 1).to_i), emoji: emoji.sample, location: Faker::Nation.capital_city, publish_date: (index.days.ago))
end

(1..5).each do |index|
  Article.create(admin: admin, title: Faker::Lorem.sentence, body: makdown_sandwich(sentences: (5 * rand + 1).to_i, repeat: (3 * rand + 1).to_i), emoji: emoji.sample, location: Faker::Nation.capital_city, publish_date: (index.days.from_now))
end