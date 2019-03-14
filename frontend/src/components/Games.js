import React, { Component } from "react";

export default class Games extends Component {
  handleGameClick = (gameId) => () => {
    this.props.handleData({
      selectedGame: gameId
    })
  }

  renderGame = (game) => {
    return(
      <div className={ `games__game ${game.status}` } key={game.id}>
        <p>Started at: { game.startTime }</p>
        <p>Status: { game.status }</p>
        <button onClick={this.handleGameClick(game.id)}>
          { game.status === "active" ? "Play" : "See" }
        </button>
      </div>
    );
  }

  render() {
    return (
      <div className="games">
        { this.props.games.map(this.renderGame) }
      </div>
    );
  }
}
