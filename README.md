# Legendary Pancake Updated

A community pancake recipe sharing platform (the best!) built with Ruby on Rails 8. Browse, create, edit, and delete pancake recipes complete with ingredients and user reviews.

## Features

- Full CRUD for pancake recipes
- Nested ingredient management
- User reviews with star ratings
- Search recipes by name/description
- Filter by difficulty (easy, medium, hard)
- Redis-backed caching
- 100 seeded recipes with Faker data

## Tech Stack

- Ruby 3.3 / Rails 8
- PostgreSQL
- Redis (caching)
- Hotwire (Turbo + Stimulus)

## Prerequisites

- Ruby 3.3+
- PostgreSQL
- Redis

## Setup

```bash
git clone <repo-url> && cd legendary-pancake
bundle install
```

Set environment variables (optional, falls back to local defaults):

```bash
export SCHEMA_TO_GO_URL="postgres://user:pass@host:5432/dbname"
export CACHE_TO_GO_URL="redis://host:6379/1"
```

Create and seed the database:

```bash
bin/rails db:create db:migrate db:seed
```

Start the server:

```bash
bin/rails server
```

Visit `http://localhost:3000`.

## Environment Variables

| Variable | Description | Default |
|---|---|---|
| `SCHEMA_TO_GO_URL` | PostgreSQL connection URL | Local PostgreSQL |
| `CACHE_TO_GO_URL` | Redis connection URL | `redis://localhost:6379/1` |

## Database Schema

- **recipes** - name, description, difficulty, prep_time_minutes, cook_time_minutes, servings, image_url
- **ingredients** - recipe_id, name, quantity, unit
- **reviews** - recipe_id, author_name, rating (1-5), comment
