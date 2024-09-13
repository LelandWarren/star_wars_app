# Star Wars API Explorer

This is a Ruby on Rails application that interacts with the [Star Wars API](https://swapi.dev) to display data about films, people, and vehicles. The app provides a table view of films, people, and vehicles with detailed views for each entity. It also features caching with Redis to improve performance.

For more details on the architecture and technical implementation, see the [Developer's Guide](dev-doc.md).


## Features

- View films, people, and vehicles from the Star Wars universe.
- Detailed view for each film, person, and vehicle.
- Related objects (e.g., people in films, vehicles in films) are linked to their respective details.
- Caching using Redis to improve response times and reduce API calls.
- Loading spinner for smoother user experience while fetching data.

## Prerequisites

To run this project locally, you'll need the following installed on your Mac:

1. **Ruby** (preferably version 3.0 or higher)
2. **Rails** (version 7.0 or higher)
3. **Redis** (for caching)
4. **Bundler** (gem for managing Ruby dependencies)
5. **PostgreSQL** (or other DBs; adjust if necessary)

### 1. Install Ruby and Rails

You can install Ruby using a version manager like `rbenv` or `rvm`. Here's an example of using `rbenv`:

```
brew install rbenv
rbenv install 3.0.0
rbenv global 3.0.0
```

Then install Rails:

```
gem install rails
```

Verify your installations:

```
ruby -v
rails -v
```

### 2. Install Redis

Install Redis via Homebrew:

```
brew install redis
brew services start redis
```

Verify Redis is running:

```
redis-cli ping
```

You should see `PONG`.


---

## Getting Started

### 1. Clone the Repository

First, clone this repository to your local machine:

```
git clone https://github.com/yourusername/star_wars_app.git
cd star_wars_app
```

### 2. Install Dependencies

Install the necessary gems using Bundler:

```
bundle install
```

### 3. Set Up Redis

Ensure Redis is running (via Homebrew):

```
brew services start redis
```

If Redis is not running, start it manually:

```
redis-server
```

### 5. Running the Application

Start the Rails server:

```
rails server
```

Visit `http://localhost:3000` in your browser to view the application.

```

---

## How to Use

- **Films**: On the landing page, you'll see a table view of films with clickable links to view film details.
- **People**: Navigate to the People section using the navigation bar, and view a list of people with links to their details.
- **Vehicles**: Similarly, the Vehicles section lists Star Wars vehicles with links to details.
- **Related Objects**: In the details view of any film, person, or vehicle, you'll see related entities linked. Clicking those links will take you to the respective detail view.

---

## Caching

This application uses Redis for caching API responses to improve performance. Redis caches film, person, and vehicle data, reducing redundant API calls. The cache expiration is set to 12 hours by default.

You can flush the cache by running:

```
redis-cli flushall
```

---

## Troubleshooting

1. **Redis isn't running**:
   - Ensure Redis is started with `brew services start redis` or run `redis-server` manually.

---
