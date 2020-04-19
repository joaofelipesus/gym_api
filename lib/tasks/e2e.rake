namespace :e2e do
  desc "Generates data used in e2e tests to validate"
  task setup: :environment do
    User.create([
      { email: 'user@user.com', password: '123123', kind: :user },
      { email: 'admin@admin.com', password: '123123', kind: :admin },
      { email: 'without@training.routine',password: '123123', kind: :user },
    ])
    user = User.create({ email: 'with@training.routine', password: '123123', kind: :user })
    TrainingRoutine.create(user: user) if user.valid?
  end

  desc "Clean all data used in e2e tests"
  task clean: :environment do
    User.find_by(email: 'user@user.com').destroy
    User.find_by(email: 'admin@admin.com').destroy
    User.find_by(email: 'without@training.routine').destroy
    user = User.find_by(email: 'with@training.routine')
    TrainingRoutine.find_by(user: user).destroy
    user.destroy
  end
end
