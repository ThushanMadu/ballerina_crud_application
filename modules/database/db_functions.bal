import ballerina/sql;

// Fetch all users from the database.
// Returns an array of User records or an sql:Error on failure.
public isolated function getUsers() returns User[]|sql:Error {
    // Execute the query and return a stream of user records.
    stream<User, sql:Error?> resultStream = dbClient->query(getUsersQuery());
    
    // Check if the result is a stream of user records.
    if resultStream is stream<User> {
        // Collect all users from the stream and return as an array.
        return from User user in resultStream
            select user;
    }
    
    // If there is an error, return an error message.
    return error("Error fetching users from the database");
}

// Insert a new user into the database.
public isolated function insertUser(UserCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertUserQuery(payload));
}

// Delete a user from the database by user ID.
public isolated function deleteUser(int userId) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteUserQuery(userId));
}

// Update a user's information in the database by user ID.
public isolated function updateUser(int userId, UserUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updateUserQuery(userId, payload));
}

// Fetch a single user by their ID.
public isolated function getUserById(int userId) returns User|sql:Error? {
    // Execute the query and get a stream of user records
    stream<User, sql:Error?> resultStream = dbClient->query(getUserByIdQuery(userId));
    
    // Get the first record from the stream
    record {| User value; |}|sql:Error? result = resultStream.next();
    
    // Close the stream
    check resultStream.close();
    
    // If a record is found, return the User
    if result is record {| User value; |} {
        return result.value;
    }

    return null;
}

// Fetch users by their name (search).
public isolated function getUsersByName(string name) returns User[]|sql:Error {
    // Execute the query to search users by name.
    stream<User, sql:Error?> resultStream = dbClient->query(getUsersByNameQuery(name));
    User[] users = [];
    // Collect users from the stream into an array.
    error? e = from User user in resultStream
        do {
            users.push(user);
        };
    // If there was an error during streaming, return an error.
    if e is error {
        return error("Error fetching users by name from the database");
    }
    return users;
}






