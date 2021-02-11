FactoryBot.define do
  factory :article do
    content { Faker::Lorem.characters(number: 10) }
    after(:build) do |article|
      article.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'Ellipse.png')), filename: 'Ellipse.png', content_type: 'image/png')
    end
  end
end
