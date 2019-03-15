import React, { Component } from "react";
import moment from "moment";

import { createGame } from "../../client/Minesweeper";
import "./Games.css";

export default class Games extends Component {
  constructor() {
    super();
    this.state = {
      rowsSize: "",
      columnsSize: "",
      minesAmount: "",
    }
  }

  handleChange = (e) => {
    const name = e.target.name;
    const value = e.target.value;
    this.setState({
      [name]: value
    });
  }

  handleGameClick = (gameId) => () => {
    this.props.handleData({
      selectedGameId: gameId
    })
  }

  handleNewGame = (e) => {
    e.preventDefault();

    const { rowsSize, columnsSize, minesAmount } = this.state;
    createGame({ columnsSize, rowsSize, minesAmount })
      .then(response => {
        const game = response.data;
        this.props.handleData({
          selectedGameId: game.id
        });
      })
  }

  renderGame = (game) => {
    return(
      <div className={ `games__game ${game.status}` } key={game.id}>
        <p>Started at { moment(game.startTime).format("LLL") }</p>
        <p>Size: { game.rowsSize } x { game.columnsSize }</p>
        <p>Mines: { game.minesAmount }</p>
        <p>{ game.status.toUpperCase() }</p>
        <button onClick={this.handleGameClick(game.id)}>
          { game.status === "active" ? "Play" : "See" }
        </button>
      </div>
    );
  }

  render() {
    const { rowsSize, columnsSize, minesAmount } = this.state;
    const games = this.props.games.sort((a, b) => {
      if (a.status === "active" && b.status !== "active") {
        return -1;
      }
      if (b.status === "active" && a.status !== "active") {
        return 1;
      }
      return 0;
    });
    return (
      <main className="games">
        <form onSubmit={this.handleNewGame}>
          <h2>Set up your board and start playing 🕵️‍♀️</h2>
          <input type="number" min="0" max="50" name="rowsSize" placeholder="Rows" value={rowsSize} onChange={this.handleChange}/>
          <input type="number" min="0" max="50" name="columnsSize" placeholder="Columns" value={columnsSize} onChange={this.handleChange}/>
          <input type="number" min="0" name="minesAmount" placeholder="Mines" value={minesAmount} onChange={this.handleChange}/>
          <button type="submit">New game</button>
        </form>
        { games.sort().map(this.renderGame) }
      </main>
    );
  }
}
