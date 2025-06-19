


import ballerina_crud_application.database;

import ballerina/http;
import ballerina/sql;

service / on new http:Listener(9090) {

    // Resource function to get all User.
    resource function get users() returns database:User[]|http:InternalServerError {
        // Call the getusers function to fetch data from the database.
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

    resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertUser(user);
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting user"
            };
        }
        return http:CREATED;
    }

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
}


