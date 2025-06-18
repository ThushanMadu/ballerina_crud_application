import ballerina/sql;

isolated function getUsersQuery() returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email,
        phone,
        created_at,
        updated_at
    FROM 
        users;
`;
isolated function insertUserQuery(UserCreate payload) returns sql:ParameterizedQuery => `
    INSERT INTO users
        (
            name,
            email,
            phone
        )
    VALUES
        (
            ${payload.name},
            ${payload.email},
            ${payload.phone}
        )
`;
isolated function deleteUserQuery(int userId) returns sql:ParameterizedQuery => `
    DELETE FROM users WHERE id = ${userId}
`;
isolated function updateUserQuery(int userId, UserUpdate payload) returns sql:ParameterizedQuery => `
    UPDATE users
        SET
            name = COALESCE(${payload.name}, name),
            email = COALESCE(${payload.email}, email),
            phone = COALESCE(${payload.phone}, phone)
        WHERE id = ${userId}
`;
