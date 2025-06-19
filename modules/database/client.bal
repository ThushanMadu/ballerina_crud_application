// Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 LLC. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerinax/mysql;
import ballerinax/mysql.driver as _;

# Represents the configuration required to connect to the MySQL database.
type DatabaseConfig record {|
    # User of the database
    string user;
    # Password of the database
    string password;
    # Name of the database
    string database;
    # Host of the database
    string host;
    # Port number of the database
    int port;
|};

# Database Client Configuration loaded from the configuration file.
configurable DatabaseConfig dbConfig = ?;

# MySQL database client instance.
# This client is used for executing queries and interacting with the database.
final mysql:Client dbClient = check new (
    user = dbConfig.user,
    password = dbConfig.password,
    database = dbConfig.database,
    host = dbConfig.host,
    port = dbConfig.port
);