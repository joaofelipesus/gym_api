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
    create_user_with_workout email: 'with@workout.com'
    create_user_with_training_routine email: 'with@duplicated.workout'
    create_user_with_workout email: 'start@workout.com'
    create_user_with_workout_progress email: 'workout@in.progress'
    create_user_with_workout email: 'user@start.workout'
    create_user_with_workout_progress email: 'user@workout-report.progress'
    create_user_with_workout_progress email: 'exercise@report.com'
    create_user_with_workout_progress email: 'finish@workout.report'
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
    destroy_user email: 'start@workout.com'
    destroy_user email: 'workout@in.progress'
    destroy_user email: 'user@start.workout'
    destroy_user email: 'user@workout-report.progress'
    destroy_user email: 'exercise@report.com'
    destroy_user email: 'finish@workout.report'
    destroy_exercises
  end

  private 

    def destroy_user email: ''
      user = User.find_by email: email
      user.training_routines.each do |training_routine|
        training_routine.workouts.each do |workout|
          workout.workout_exercises.each do |workout_exercise|
            workout_exercise.exercise_reports.each do |exercise_report|
              exercise_report.series_reports.destroy_all
              exercise_report.destroy
            end
            workout_exercise.destroy
          end
          workout.workout_reports.each do |workout_report|
            workout_report.destroy
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
    
    def create_user_with_workout email: ''
      user = create_user_with_training_routine email: email
      if user.valid?
        workout = Workout.new({name: 'A', classes_to_attend: 20, training_routine: user.training_routines.last})
        workout_exercise = WorkoutExercise.new(repetitions: 20, rest_time: 40, exercise: Exercise.last, series_number: 3)
        workout.workout_exercises << workout_exercise
        workout.save
        return user
      end
    end

    def create_user_with_workout_progress email: ''
      user = create_user_with_workout email: email
      if user
        workout = user.training_routines.last.workouts.last
        WorkoutReport.create(workout: workout)
      end
    end

    def destroy_exercises
      Exercise.all.each do |exercise|
        exercise.destroy if exercise.workout_exercises.empty?
      end
    end

end
