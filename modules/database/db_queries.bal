import ballerina/sql;

# Build query to retrieve all users from the database.
#
# + return - sql:ParameterizedQuery containing SELECT statement for all users
isolated function getUsersQuery() returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        address
    FROM 
        user;
`;

# Build query to insert a new user into the database.
#
# + payload - UserCreate record containing the user details to insert
# + return - sql:ParameterizedQuery containing INSERT statement with user data
isolated function insertUserQuery(UserCreate payload) returns sql:ParameterizedQuery => `
    INSERT INTO user
        (
            name,
            email,
            address
        )
    VALUES
        (
            ${payload.name},
            ${payload.email},
            ${payload.address}
        
        )
`;

# Build query to delete a user from the database by ID.
#
# + userId - ID of the user to delete
# + return - sql:ParameterizedQuery containing DELETE statement for specified user
isolated function deleteUserQuery(int userId) returns sql:ParameterizedQuery => `
    DELETE FROM user WHERE id = ${userId}
`;

# Build query to update an existing user's information.
# Uses COALESCE to retain existing values when update payload fields are null.
#
# + userId - ID of the user to update
# + payload - UserUpdate record containing the fields to update
# + return - sql:ParameterizedQuery containing UPDATE statement with user data
isolated function updateUserQuery(int userId, UserUpdate payload) returns sql:ParameterizedQuery =>`
    UPDATE user
        SET 
            name = COALESCE(${payload.name}, name),
            email = COALESCE(${payload.email}, email),
            address = COALESCE(${payload.address}, address)
        WHERE id = ${userId}
`;

# Build query to fetch a specific user by ID.
#
# + userId - ID of the user to retrieve
# + return - sql:ParameterizedQuery containing SELECT statement for specified user
isolated function getUserByIdQuery(int userId) returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        address
    FROM 
        user
    WHERE 
        id = ${userId};
`;

# Build query to search for users by name (partial match).
# Uses LIKE operator with wildcards for partial name matching.
#
# + name - Name or partial name to search for
# + return - sql:ParameterizedQuery containing SELECT statement with name filter
isolated function getUsersByNameQuery(string name) returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        address
    FROM 
        user
    WHERE 
        name LIKE ${"%" + name + "%"};
`;
