FactoryBot.define do
  factory :user do
    transient do
      person {Gimei.name}
    end
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    birth_date_id         {'1930-01-01'}
    last_name             {'あア亜'}
    first_name            {'あア亜'} 
    last_name_kana        {person.last.katakana}
    first_name_kana       {person.first.katakana}         
  end
end