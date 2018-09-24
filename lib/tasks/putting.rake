namespace :putting do
  desc "putting nice word"
  task nice_word: :environment do
    p %w[love doggie puppy friendship].sample
  end

end
