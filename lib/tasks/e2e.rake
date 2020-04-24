namespace :e2e do
  desc "Generates data used in e2e tests to validate"
  task setup: :environment do
    User.create([
      { email: 'user@user.com', password: '123123', kind: :user },
      { email: 'admin@admin.com', password: '123123', kind: :admin },
      { email: 'without@training.routine',password: '123123', kind: :user },
    ])
    create_user_with_training_routine email: 'with@training.routine'
    create_user_with_training_routine email: 'without@workout.com'
    create_user_with_workout
    create_user_with_training_routine email: 'with@duplicated.workout'
  end

  desc "Clean all data used in e2e tests"
  task clean: :environment do
    destroy_user email: 'user@user.com'
    destroy_user email: 'admin@admin.com'
    destroy_user email: 'without@training.routine'
    destroy_user email: 'with@training.routine'
    destroy_user email: 'with@workout.com'
    destroy_user email: 'without@workout.com'
    destroy_user email: 'with@duplicated.workout'
  end

  private 

    def destroy_user email: ''
      user = User.find_by email: email
      user.training_routines.each do |training_routine|
        training_routine.workouts.each do |workout|
          workout.workout_exercises.each do |workout_exercise|
            workout_exercise.destroy
          end
          workout.destroy
        end 
        training_routine.destroy
      end
      user.destroy
    end

    def create_user_with_training_routine email: ''
      user = User.create({ email: email, password: '123123', kind: :user })
      TrainingRoutine.create(user: user) if user.valid?
      user
    end
    
    ############################################################################################################

    def create_user_with_workout
      user = create_user_with_training_routine email: 'with@workout.com'
      if user.valid?
        workout = Workout.new({name: 'A', classes_to_attend: 20, training_routine: user.training_routines.last})
        workout_exercise = WorkoutExercise.new(repetitions: 20, rest_time: 40, exercise: Exercise.last)
        workout.workout_exercises << workout_exercise
        workout.save
      end
    end

end
