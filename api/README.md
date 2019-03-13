# Minesweeper API

### First steps
Make sure you have ruby installed (I used 2.6.1)
Also make sure you have postgresql installed and running
You'll need to create the database (`bundle exec rails db:setup`)

### Model definition

1. User
  - UUID: uuid (unique)
  - Name: string

2. Game
  - Start: datetime
  - End: datetime
  - Cells: array of integers
  - Opened cells: array of integers
  - Flagged cells: array of integers
  - Status: [active, lost, won]

### Services

*Board service* handles the board creation, which is actually an one-dimensional array.
