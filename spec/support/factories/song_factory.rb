FactoryGirl.define do
  factory :song do
    name  'For whom the bell tolls'
    file  { File.open(File.join(Rails.root, 'spec', 'support', 'assets', 'songs', '03 For Whom the Bell Tolls.mp3'))}
  end
end
