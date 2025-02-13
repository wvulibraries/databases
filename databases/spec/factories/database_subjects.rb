FactoryBot.define do
  factory :database_subject do
    association :database, factory: :database
    association :subject, factory: :subject
  end
end
