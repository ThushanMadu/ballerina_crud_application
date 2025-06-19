

import ballerina/sql;

isolated function getUsersQuery() returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        address
    FROM 
        user;
`;

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

isolated function deleteUserQuery(int userId) returns sql:ParameterizedQuery => `
    DELETE FROM user WHERE id = ${userId}
`;

isolated function updateUserQuery(int userId, UserUpdate payload) returns sql:ParameterizedQuery =>`
    UPDATE user
        SET 
            name = COALESCE(${payload.name}, name),
            email = COALESCE(${payload.email}, email),
            address = COALESCE(${payload.address}, address)
        WHERE id = ${userId}
`;

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