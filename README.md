# Ballerina CRUD Application

A simple CRUD (Create, Read, Update, Delete) REST API built with [Ballerina](https://ballerina.io/) that manages user records in a MySQL database.

## Features

- RESTful API for user management
- MySQL database integration
- Search users by name
- Patch support for partial updates
- Error handling with appropriate HTTP status codes

## Project Structure

```
ballerina_crud_application/
├── .devcontainer.json
├── .gitignore
├── Ballerina.toml
├── Config.toml
├── Dependencies.toml
├── service.bal
├── types.bal
├── lib/
│   └── mysql-connector-j-8.0.33.jar
├── modules/
│   └── database/
│       ├── client.bal
│       ├── db_functions.bal
│       ├── db_queries.bal
│       ├── types.bal
│       └── utils.bal
├── resources/
│   └── databse/
│       └── databse.sql
└── target/
```

## Getting Started

### Prerequisites

- [Ballerina](https://ballerina.io/downloads/) 2201.12.6 or compatible
- MySQL server
- Java (for MySQL connector)

### Setup

1. **Clone the repository:**
   ```sh
   git clone https://github.com/ThushanMadu/ballerina_crud_application.git
   cd ballerina_crud_application
   ```

2. **Configure the database:**
   - Create a MySQL database and user.
   - Run the SQL script in [`resources/databse/databse.sql`](resources/databse/databse.sql) to set up the schema and initial data.

3. **Configure database connection:**
   - Copy `Config.toml` and set your MySQL credentials:
     ```toml
     [ballerina_crud_application.database.dbConfig]
     user = "<db_user>"
     password = "<db_password>"
     database = "<db_name>"
     host = "localhost"
     port = 3306
     ```

4. **Add MySQL Connector:**
   - Ensure `lib/mysql-connector-j-8.0.33.jar` exists. If not, download from [MySQL](https://dev.mysql.com/downloads/connector/j/).

5. **Build the project:**
   ```sh
   bal build
   ```

6. **Run the service:**
   ```sh
   bal run
   ```

## API Endpoints

| Method | Endpoint                | Description                |
|--------|------------------------ |----------------------------|
| GET    | `/users`                | Get all users              |
| GET    | `/users/{id}`           | Get user by ID             |
| POST   | `/users`                | Create a new user          |
| DELETE | `/users/{id}`           | Delete user by ID          |
| PATCH  | `/users/{id}`           | Update user (partial)      |
| GET    | `/users/search?name=xx` | Search users by name       |

## License

This project is licensed for educational and demonstration purposes.

## Copyright

&copy; 2025 Thushan M. All rights reserved.

---

*Powered by [Ballerina](https://ballerina.io/)*