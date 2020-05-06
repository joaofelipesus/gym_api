# gym app API

This app was develop to serve as a better way to manage my workouts on the gym, and as a case of study to Vue tool. This applications serve as API to be consumed only by the client https://treinohype.herokuapp.com.

* Ruby version: **2.7.1**
* Rails version **6.0.2**

* In order to run the project you need to have **Docker** and **docker-compose** installed.

* Development was made using docker and docker-compose, so to run the project you need to first build the containers (**docker-compose build**) then start it (**docker-compose up**). It will start the server on localhost:3000 as a default rails 6 app.

* Once the container is configured you just **run default rails:db tasks** to create and migrate the database, which is very simple, and there is no need to run db:seeds.

* To **run test suite** just run on command line *docker-compose exec app bundle exec rspec*.

* The rails tasks **e2e:setup** and **e2e:clean** are used to provide seeds used on End to End specs implemented using nightwatch, the code are present on the client app (https://github.com/joaofelipe1294/gym-client).
