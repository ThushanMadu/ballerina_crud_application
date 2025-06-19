import ballerina/sql;

// Define the function to fetch users from the database.
public isolated function getUsers() returns User[]|sql:Error {
    // Execute the query and return a stream of user records.
    stream<User, sql:Error?> resultStream = dbClient->query(getUsersQuery());
    
    // Check if the result is a stream of user records.
    if resultStream is stream<User> {
        return from User user in resultStream
            select user;
    }
    
    // If there is an error, return an error message.
    return error("Error fetching users from the database");
}

public isolated function insertUser(UserCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertUserQuery(payload));
}

public isolated function deleteUser(int userId) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteUserQuery(userId));
}

public isolated function updateUser(int userId, UserUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updateUserQuery(userId, payload));
}




