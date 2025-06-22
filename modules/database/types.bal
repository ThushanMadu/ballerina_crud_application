

import ballerina/sql;

# User record type.
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

    # User address
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