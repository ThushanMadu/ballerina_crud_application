import ballerina_crud_application.database;

import ballerina/http;
import ballerina/sql;

// HTTP service listening on port 9090 for user CRUD operations.
service / on new http:Listener(9090) {

    // Resource function to get all users.
    // Returns an array of User records or an InternalServerError.
    # Retrieves all users from the database.
    #
    # + return - An array of User records if successful, or an InternalServerError if an error occurs.
    resource function get users() returns database:User[]|http:InternalServerError {
        database:User[]|error response = database:getUsers();
        if response is error {
            return <http:InternalServerError>{
                body: "Error while retrieving users"
            };
        }
        return response;
    }

    // Resource function to create a new user.
    // Accepts a UserCreate payload and returns HTTP 201 Created or InternalServerError.
    resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertUser(user);
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting user"
            };
        }
        return http:CREATED;
    }

    // Resource function to delete a user by ID.
    // Returns HTTP 204 NoContent, 404 NotFound, or InternalServerError.
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

    // Resource function to get a user by ID.
    // Returns a User record, 404 NotFound, or InternalServerError.
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

    // Resource function to search users by name.
    // Returns an array of User records, 404 NotFound, or InternalServerError.
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

    // Resource function to update a user by ID (partial update).
    // Accepts a UserUpdate payload and returns HTTP 204 NoContent, 404 NotFound, or InternalServerError.
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


