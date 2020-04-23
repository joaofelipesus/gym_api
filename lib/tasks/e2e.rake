namespace :e2e do
  desc "Generates data used in e2e tests to validate"
  task setup: :environment do
    setup_exercises
    User.create([
      { email: 'user@user.com', password: '123123', kind: :user },
      { email: 'admin@admin.com', password: '123123', kind: :admin },
      { email: 'without@training.routine',password: '123123', kind: :user },
    ])
    user = User.create({ email: 'with@training.routine', password: '123123', kind: :user })
    TrainingRoutine.create(user: user) if user.valid?
    create_user_with_workout
  end

  desc "Clean all data used in e2e tests"
  task clean: :environment do
    User.find_by(email: 'user@user.com').destroy
    User.find_by(email: 'admin@admin.com').destroy
    User.find_by(email: 'without@training.routine').destroy
    user = User.find_by(email: 'with@training.routine')
    if user
      TrainingRoutine.find_by(user: user).destroy
      user.destroy
    end
    destroy_user_with_workout
  end

  private 

    def setup_exercises
      Exercise.delete_all
      5.times { Exercise.create(name: Faker::Internet.ip_v6_address) }
    end

    def create_user_with_workout
      user = User.create({ email: 'with@workout.com', password: '123123', kind: :user })
      if user.valid?
        training_routine = TrainingRoutine.create(user: user)
        workout = Workout.new({name: 'A', classes_to_attend: 20, training_routine: training_routine})
        workout_exercise = WorkoutExercise.new(repetitions: 20, rest_time: 40, exercise: Exercise.last)
        workout.workout_exercises << workout_exercise
        workout.save
      end
    end

    def destroy_user_with_workout
      user = User.find_by email: 'with@workout.com'
      user.training_routines.last.workouts.last.workout_exercises.destroy_all
      user.training_routines.last.workouts.destroy_all
      user.training_routines.destroy_all
      user.destroy      
    end
end
