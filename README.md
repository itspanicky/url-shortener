# Short App is an application for shortening url

#### Url Shortening Algorithm
A simple, yet effective, formula by multiplying the short_url id by a factor and coverting the result into a string representation with base 26. This results in a shorten hash that points to the full url. 
- The factor that is multiplied by the short_url id, is an arbitrary number that can be hidden in a env file for security reasons. This factor prevents easy-to-guess short codes such as "1" from being generated.
- This hashing method allows for a two-way lookup. Given just the short_code, such as when a user attempts to visit back the full_url, a reverse lookup to find the short_url is possible by coverting the short code string back into an integer with base 26 and dividing the value by the same factor.


# Intial Setup

    docker-compose build
    docker-compose up mariadb
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc
