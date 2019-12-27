admin = Admin.create(email: 'testadmin@rullmann.ca', password: 'Testing123', password_confirmation: 'Testing123')

emoji = %w[🤠 😁 👨‍💻 🖖 👋 🧵 👑 🙏]

(1..20).each do |index|
  Article.create(skip_date_validation: true, admin: admin, title: Faker::Lorem.sentence, body: Faker::Markdown.sandwich(sentences: (5 * rand).to_i), emoji: emoji.sample, location: Faker::Nation.capital_city, publish_date: (index.days.ago))
end

(1..5).each do |index|
  Article.create(admin: admin, title: Faker::Lorem.sentence, body: Faker::Markdown.sandwich(sentences: (5 * rand).to_i), emoji: emoji.sample, location: Faker::Nation.capital_city, publish_date: (index.days.from_now))
end