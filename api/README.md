# Minesweeper API

Lives at https://minesweeper-api-jm.herokuapp.com

## First steps
- Make sure you have ruby installed (I used 2.6.1)
- Also make sure you have postgresql installed and running
- You'll need to create the database (`bundle exec rails db:create db:migrate`)
- To start the server run `bundle exec rails s`

## Model definition

1. User
    - UUID: uuid (unique)
    - Name: string

2. Game
    - Start time: datetime
    - End time: datetime
    - Mines amount: integer
    - Rows size: integer
    - Columns size: integer
    - Cells: array of integers
    - Opened cells: array of integers
    - Flagged cells: array of integers
    - Status: [active, lost, won]

Cells stores the board with all the data (mines, indicators and empty spaces).
Cells is a one-dimensional array containing the board.

`Game#current_cells` discloses the board with the opened and flagged cells.

## Routes
- Users with create, update and show.
- Games with create, update and show. The update action will handle opening and flagging cells.

## Services
#### Board service

- Handles the board creation, which is actually an one-dimensional array.
- Randomize the mines creation.
- Raises errors if amount of mines is greater than amount of cells, and also if the amount of mines is zero.

#### Game service

- Handles the update of the game object (I was intending not to touch the database in the service layer, but for simplicity I ended up using active record in here).
- When the user decides to open a cell, this service will run the flood-fill algorithm (recursively) in the cells array, trying to open all the adjacent cells available.

## "Session" management

- Each user is provided with an UUID.
- Every request should have the header `X-Minesweeper-User-Uuid` so that the controller can set the current user.
- It will raise an error if the current user is not found, except for the create user endpoint.

## Miscellaneous

- Added active model serializer
- Added rack-cors (anything is whitelisted though)

## Tests

- Board service spec
- Game service spec TODO
- Controllers TODO

