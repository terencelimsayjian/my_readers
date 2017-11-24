# MYReaders

## Description

MyReaders is a literacy programme started by TeachForMalaysia alumni that is currently adopted and run in select schools in Malaysia. This literacy portal aims to provide an avenue for facilitators of this programme to add and track diagnostic data from the students in the programme.

The portal also has an admin interface, where the programme owners can log in and view diagnostic data across participating schools.

## Setup

1. Clone the repository
```
git clone https://github.com/terencelimsayjian/my_readers.git
```

2. Run bundler
```
cd my_readers
bundle install
```

3. Set up the development database
```
rake db:create db:migrate dev:prime
```

## Branch Policy

We follow the [Github Flow](https://guides.github.com/introduction/flow/) when developing the application, and name our branches as follow:

- `master` is the active development branch

Local development branch naming:

- `feature/<your-branch-name>` for substantial new feature or function
- `enhance/<your-branch-name>` for minor feature or function enhancement
- `bugfix/<your-branch-name>` for bug fixes

## ERD

https://www.lucidchart.com/invitations/accept/a36d5480-8344-4a62-9f18-08e41ea58442

## KIV
* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
