import ballerina/sql;

# User record type.
public type User record {|
    # Unique identifier for the user.
    @sql:Column {name: "id"}
    readonly int id;

    # Name of the user.
    @sql:Column {name: "name"}
    string name;

    # Email address of the user.
    @sql:Column {name: "email"}
    string email;

    # Address of the user.
    @sql:Column {name: "address"}
    string address;
|};        

# User create record type.
public type UserCreate record {|
    # User name
    string name;
    # User email
    string email;
    # User address
    string address;
    
|};

# User update record type.
public type UserUpdate record {|
    # User name
    string? name = ();
    # User email
    string? email = ();
    # User address
    string? address = ();
|};