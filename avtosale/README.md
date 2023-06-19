# Usage

To use this web app, Ruby will need to be installed. This program is build on Ruby ruby-3.2.0. To check your current version:

ruby -v

Clone the repository of Rails project. Run

bundle install

Next, execute the database migrations/schema setup:

rails db:migrate

To seed the database with its default values run:

bundle exec rails db:seed

Run the program from the app root

$ rails s

If you want to run hooks group directly run:

overcommit --run

Expected terminal output:

Running pre-commit hooks
Analyzing for potential speed improvements.................[Fasterer] OK
Analyze with RuboCop........................................[RuboCop] OK

✓ All pre-commit hooks passed

Run full test suite to see the percent coverage that application has:

rspec

Open coverage/index.html in the browser of your choice. For example, in a Mac Terminal, run the following command from your application's root directory:

open coverage/index.html

in a debian/ubuntu Terminal,

xdg-open coverage/index.html
