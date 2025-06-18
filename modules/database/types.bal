import ballerina/mysql;
import ballerina/configurable;
import ballerina/sql;
type DatabaseConfig record {|
    # User of the database
    string user;
    # Password of the database
    string password;
    # Name of the database
    string database;
    # Host of the database
    string host;
    # Port
    int port;
|};

# Database Client Configuration.
configurable DatabaseConfig dbConfig = ?;

final mysql:Client dbClient = check new (
    user = dbConfig.user,
    password = dbConfig.password,
    database = dbConfig.database,
    host = dbConfig.host,
    port = dbConfig.port
);

public type User record {|
    # User ID
    @sql:Column {name: "id"}
    readonly int id;

    # User name
    @sql:Column {name: "name"}
    string name;

    # User email
    @sql:Column {name: "email"}
    string email;

    # User phone number
    @sql:Column {name: "phone"}
    string phone;

    # Created timestamp
    @sql:Column {name: "created_at"}
    string createdAt;

    # Last updated timestamp
    @sql:Column {name: "updated_at"}
    string updatedAt;
|};

# User create record type.
public type UserCreate record {|
    # User name
    string name;
    # User email
    string email;
    # User phone number
    string phone;
|};
# User update record type.
public type UserUpdate record {|
    string? name = ();
    string? email = ();
    string? phone = ();
|};
