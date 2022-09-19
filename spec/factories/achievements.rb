FactoryBot.define do
  factory :achievement do
    title { "MyString" + rand(10000).to_s }
    description { "MyText" }
    featured { false }
    cover_image { "MyString" }

    factory :public_achievement do
      privacy { :public_access }
    end

    factory :private_achievement do
      privacy { :private_access }
    end
  end
end
