# Snapshift Technical Test

Thanks for taking our test! This exercise is meant to let you show different kinds of skills.
It should take roughly 4 hours. You can spend more but we would like you to tell us :)

Instructions are below. 

Good Luck!

## Setup
You can run the app the way you prefer. 

### Docker
It has been dockerized to save you some time if you are used to it.

```
docker compose run puma bash
```

would let you enter a bash with database ready.

### No Docker
You would need a postgres database running and probably adapt the `config/database.yml`

### Common steps

You will need to prepare your database:
```
bundle exec rails db:setup
```

Tests should run:
```
bundle exec rspec spec
```

## Shift API

### Goal
The goal of the first part of the test is to update the `ShiftsController` which is meant to be a part of a JSON API.

What you need to do is:
- Add code to the CRUD actions to respect the rules in the section below
- For the index action, handle different filtering criteria: retrieve only shifts during the week-end, during the morning or during the afternoon. These 3 criterias can be combined in a single request with an OR.
- Write request tests for the `ShiftsController` (in the`spec/requests/api/v1/shifts_spec.rb` file)

### Rules
An employee can:
- See their own shifts.
- See the shifts of their colleagues.
- Update their shifts real hours (`real_starts_at`, `real_ends_at`) **only** if the shift is not locked (`locked_at` is `NULL`).

An admin can:
- Do everything an employee can.
- Create, update and destroy shifts.

## Shift Export

### Goal
The goal of second part of the test is to generate an export of the shifts.
The export must be in CSV and return all of the attributes of the shifts and computed attributes. The list of attributes can be configured.

### Rules
- The generated CSV file must be generated asynchronously : an API call must start the generation and return the status code `200 OK`.
- The generated CSV file must contain all of the configured attributes of the shift.
- The generated CSV file must also contain a computed attribute : The shift duration (`ending - beginning`).
- The generated CSV file must also contain the time slot (full_day, morning, afternoon) of each shift, e.g : If the shift starts at 8 AM and finishes at 4 PM, it should display "full_day". If the shift starts at 8 AM and finishes at 10 AM, it should display "morning".
- Allow the possibility to change the format type of the export (csv, json, excel)

## Design / Architecture / Misc
This section is particularly expected from senior developers, yet of course all applicants are welcome to share their thoughts!
- How would you serve the Shift Export to the end users from the app?
- What would you change in the codebase? What would you improve? Why?

You do not need to actually code, you can simply write what you think down in a text file.