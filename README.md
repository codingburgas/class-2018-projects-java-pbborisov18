## Contents
* [General Information](#general-information)
* [Technologies](#technologies)
* [Launch](#launch)
* [Features](#features)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)

# General Information
The aim of the project is to organise a city's electric public transport with Java, JavaFX and MSSQL. It can break and fix busses. Re-route a route. Displays information about the buses and routes. Created for a school project. 

## Technologies
* Java 17.0.2
* JavaFX (OpenJFX) 17.0.1
* Apache Maven 3.8.5

## Launch
1. Clone the repository
2. Execute the .sql file in ssms
3. [Create a login to your database](https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/create-a-login?view=sql-server-ver16)
  - Username: sa
  - Password: 123
4. Open your preffered IDE and run the project with maven build `clean javafx:run`

## Features
* Admin login
* Realtime information
* Break a bus
* Fix a bus
* Reroute a route
* Custom algorithm which calculates buses schedule

## Project status
**In progress**

## Room for Improvement
#### To Do:
* Implement unit tests
* Style the whole application using css
* Dark/White theme
