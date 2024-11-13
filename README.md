# Tea Subscription Service

> A Rails API backend for managing a Tea Subscription Service. This API provides endpoints for retrieving and managing tea subscriptions, including customer subscriptions and cancellations.


## Table of Contents
- [Introduction](#introduction)
- [Ruby Version](#ruby-version)
- [System Dependencies](#system-dependencies)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [API Endpints](#api-endpoints)

---

### Introduction
The Tea Subscription Service API is a backend application designed to manage tea subscriptions for customers. It allows for retrieving available subscriptions, viewing details of individual subscriptions (including teas and customers), and canceling subscriptions as needed.

---

### Ruby Version
Specify the Ruby version required for this project:

```plaintext
Ruby 3.2.2
```

# System Dependencies

### Core Dependencies
- **Ruby**: `3.2.2`
- **Rails**: `~> 7.1.4`
- **PostgreSQL**: Database for Active Record (`pg` gem)
- **Puma**: Web server (`>= 5.0`)

### Additional Gems
- **Faraday**: HTTP client for API requests
- **jsonapi-serializer**: JSON:API-compliant data serialization

### Development & Testing
- **pry**: Debugging tool
- **rspec-rails**: Testing framework
- **shoulda-matchers**: Simplifies testing of models
- **factory_bot_rails**: Factories for setting up test data
- **simplecov**: Test coverage reporting
- **vcr** and **webmock**: Record and stub HTTP requests for tests

---



## Database Setup

1. **Install PostgreSQL**  
   Make sure PostgreSQL is installed on your system.

2. **Configure API Key**  
   This application requires an API key to fetch tea data during the database seeding process. Add your `spoonacular` API key to your Rails credentials:

   ```bash
   EDITOR="code --wait" rails credentials:edit
   ```
   Add the following under `spoonacular`:
   ```
   spoonacular:
      api_key: your_api_key_here
   ```

3. **Create Database**  
   Run the following commands to set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed

## Running the application

To start the Rails server:

1. **Install Dependencies**  
   Ensure all gems are installed:
   ```bash
   bundle install
   ```

2. **Start the Server**
    ```bash
   rails server
   ```
3. **Access the API** 
  
   The API will be accessible at http://localhost:3000. The routes can be found in the next section
   
## API Endpoints

### 1. Get All Subscriptions

#### Postman Setup

- **Method**: `GET`
- **URL**: `http://localhost:3000/api/v1/subscriptions`

#### Headers
- No specific headers required.

#### Example Response
```json
{
    "data": [
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Bob's Weekly Tea Subscription",
                "status": "active",
                "frequency": "weekly",
                "customer_id": 2,
                "price": 74.58
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "Alice's Daily Tea Subscription",
                "status": "inactive",
                "frequency": "daily",
                "customer_id": 1,
                "price": 3.32
            }
        },
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Alice's Monthly Tea Subscription",
                "status": "active",
                "frequency": "monthly",
                "customer_id": 1,
                "price": 48.27
            }
        }
    ]
}
```
### 2. Get a Specific Subscription

This endpoint retrieves details of a specific subscription by its ID, including customer information and the teas associated with the subscription.

#### Postman Setup

- **Method**: `GET`
- **URL**: `http://localhost:3000/api/v1/subscriptions/:id`  
  Replace `:id` with the actual subscription ID (e.g., `1`).

#### Headers
- No specific headers required.

#### Example Response
```json
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "Alice's Monthly Tea Subscription",
            "status": "active",
            "frequency": "monthly",
            "price": 48.27,
            "customer": {
                "id": 1,
                "first_name": "John",
                "last_name": "Hill",
                "email": "john@example.com",
                "address": "123 Tea Lane, Teatown"
            },
            "teas": [
                {
                    "id": 1,
                    "title": "TerraVita Blueberry Banana White Tea, (Blueberry Banana,Loose Leaf White Tea, 4 oz, 1-Pack, Zin: 537954)",
                    "description": "Description not available",
                    "price": 44.95,
                    "temperature": 85,
                    "brew_time": 5
                },
                {
                    "id": 2,
                    "title": "Twinings French Vanilla Black Chai Tea Bags, 20 Count (Pack of 6)",
                    "description": "Description not available",
                    "price": 3.32,
                    "temperature": 85,
                    "brew_time": 5
                }
            ]
        }
    }
}
```

### 3. Update Subscription Status

This endpoint updates the status of a specific subscription to either "active" or "inactive".

#### Postman Setup

- **Method**: `PATCH`
- **URL**: `http://localhost:3000/api/v1/subscriptions/:id`  
  Replace `:id` with the actual subscription ID (e.g., `1`).

#### Headers
- **Content-Type**: `application/json`

#### Request Parameters
- **status** (string): The new status of the subscription. Accepts `"active"` or `"inactive"`.

#### Example Requests
To activate a subscription:
```json
{
    "status": "active"
}
```
#### Example Response
```json
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "Alice's Monthly Tea Subscription",
            "status": "active",
            "frequency": "monthly",
            "customer_id": 1,
            "price": 48.27
        }
    }
}
```