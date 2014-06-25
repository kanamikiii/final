namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entries
    make_comments
    make_relationships
    # admin = User.create!(name: "Example User",
    #              email: "admin@admin.com",
    #              password: "admin12345",
    #              password_confirmation: "admin12345",
    #              admin: true)
    # 99.times do |n|
    #   name = Faker::Name.name
    #   email = "example-#{n+1}@railstutorial.org"
    #   password = "password"
    #   User.create!(name: name,
    #                email: email,
    #                password: password,
    #                password_confirmation: password)
    # end
    # users = User.limit(6).all
    # 50.times do
    #   content = Faker::Lorem.sentence(5)
    #   users.each { |user| user.microposts.create!(content: content) }
    # end
    # users = User.all
    # user  = users.first
    # followed_users = users[2..50]
    # followers      = users[3..40]
    # followed_users.each { |followed| user.follow!(followed) }
    # followers.each      { |follower| follower.follow!(user) }
  end
end

def make_users
  admin = User.create!(name:     "Admin",
                       email:    "admin@admin.com",
                       password: "admin12345",
                       password_confirmation: "admin12345",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_entries
  users = User.limit(6).all
  20.times do
    title = Faker::Lorem.words(5).join(" ")
    #body = Faker::Lorem.paragraphs(2).join(" ")
    body = Faker::Lorem.sentence(5)
    users.each do |user| 
      user.entries.create!(title: title, body: body)
    end
  end
end

def make_comments
  users = User.limit(3).all
  users.each do |user|
    2.times do
      content = Faker::Lorem.words(10).join(" ")
      user.entries.each do |entry|
        2.times do
          entry.comments.create!(content: content)
        end
      end
    end
  end
end

def make_relationships
 users = User.all
 user  = users.first
 followed_users = users[2..50]
 followers      = users[3..40]
 followed_users.each { |followed| user.follow!(followed) }
 followers.each      { |follower| follower.follow!(user) }
end

