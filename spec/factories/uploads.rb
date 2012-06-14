# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload do
    description "MyText"
    file_url "http://simpsons.com/home.jpg"
  end
end
