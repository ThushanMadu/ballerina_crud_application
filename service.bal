import ballerina_crud_application.database;

import ballerina/http;
import ballerina/sql;

// HTTP service for managing user CRUD operations.
// 
// + service - HTTP listener on port 9090
service / on new http:Listener(9090) {

    # Retrieve all users from the database.
    # 
    # + return - Array of User records or InternalServerError if retrieval fails
    resource function get users() returns database:User[]|http:InternalServerError {
        // Call the getUsers function to fetch data from the database.
        database:User[]|error response = database:getUsers();

        // If there's an error while fetching, return an internal server error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while retrieving users"
            };
        }

        // Return the response containing the list of Users.
        return response;
    }

    # Create a new user in the database.
    # 
    # + user - UserCreate record containing the user details to be created
    # + return - HTTP 201 Created on success or InternalServerError if creation fails
    resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertUser(user);
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting user"
            };
        }
        return http:CREATED;
    }

    # Delete a user from the database by ID.
    # 
    # + id - ID of the user to delete
    # + return - HTTP 204 NoContent on success, 404 NotFound if user doesn't exist,
    #            or InternalServerError if deletion fails
    resource function delete users/[int id]() returns http:NoContent|http:NotFound|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:deleteUser(id);
        if response is sql:Error {
            return <http:InternalServerError>{
                body: "Error while deleting user"
            };
        }
        if response.affectedRowCount == 0 {
            return <http:NotFound>{
                body: "User not found with ID: " + id.toString()
            };
        }
        return http:NO_CONTENT;
    }

    # Retrieve a specific user by ID.
    # 
    # + id - ID of the user to retrieve
    # + return - User record if found, 404 NotFound if user doesn't exist,
    #            or InternalServerError if retrieval fails
    resource function get users/[int id]() returns database:User|http:NotFound|http:InternalServerError {
        database:User|sql:Error? response = database:getUserById(id);
        if response is sql:Error {
            return <http:InternalServerError>{
                body: "Error while retrieving user"
            };
        }
        if response is () {
            return <http:NotFound>{
                body: "User not found with ID: " + id.toString()
            };
        }
        return response;
    }

    # Search users by name (partial match).
    # 
    # + name - Name or partial name to search for
    # + return - Array of matching User records, 404 NotFound if no users match,
    #            or InternalServerError if search fails
    resource function get users/search(string name) returns database:User[]|http:NotFound|http:InternalServerError {
        database:User[]|sql:Error response = database:getUsersByName(name);
        if response is sql:Error {
            return <http:InternalServerError>{
                body: "Error while searching users by name"
            };
        }
        if response.length() == 0 {
            return <http:NotFound>{
                body: "No users found with name containing: " + name
            };
        }
        return response;
    }

    # Update a user's information (partial update).
    # 
    # + id - ID of the user to update
    # + user - UserUpdate record containing the fields to update
    # + return - HTTP 204 NoContent on success, 404 NotFound if user doesn't exist,
    #            or InternalServerError if update fails
    resource function patch users/[int id](database:UserUpdate user) returns http:NoContent|http:NotFound|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:updateUser(id, user);
        if response is sql:Error {
            return <http:InternalServerError>{
                body: "Error while updating user"
            };
        }
        if response.affectedRowCount == 0 {
            return <http:NotFound>{
                body: "User not found with ID: " + id.toString()
            };
        }
        return http:NO_CONTENT;
    }
}


