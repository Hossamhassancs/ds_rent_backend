# Dockerfile
FROM ruby:3.1.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile* /app/

# Install the gems
RUN bundle install

# Copy the rest of the application code
COPY . /app/

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port that Puma will run on
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b
