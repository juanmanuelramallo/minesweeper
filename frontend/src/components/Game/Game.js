import React, { Component } from "react";
import moment from "moment";

import { game, openCell, flagCells } from "../../client/Minesweeper";
import Timer from "../Timer";
import Cell from "./Cell";
import "./Game.css";

export default class Game extends Component {
  constructor() {
    super();
    this.state = {
      game: null,
      loading: true
    }
    this.boardRef = React.createRef();
  }

  componentDidMount() {
    game(this.props.selectedGameId)
      .then(response => {
        const game = response.data;
        this.setState({
          game,
          loading: false
        }, () => {
          this.boardRef.current.style.gridTemplateColumns = `repeat(${game.columnsSize}, ${800/game.columnsSize}px)`;
          this.boardRef.current.style.gridTemplateRows = `repeat(${game.rowsSize}, ${800/game.columnsSize}px)`;
        });
      });
  }

  handleOpenCell = (cell) => () => {
    openCell(cell, this.state.game.id)
      .then(response => {
        this.setState({
          game: response.data
        });
      })
  }

  handleFlagCell = (cell) => () => {
    const { game } = this.state;
    const cells = game.flaggedCells;
    const index = cells.indexOf(cell);
    if (index >= 0) {
      cells.splice(index, 1);
    } else {
      cells.push(cell);
    }

    flagCells(cells, game.id)
      .then(response => {
        this.setState({
          game: response.data
        })
      })
  }

  renderCell = (cell, index) => {
    return(
      <Cell
        cell={cell}
        index={index}
        disabled={this.state.game.status !== "active"}
        handleOpenCell={this.handleOpenCell(index)}
        handleFlagCell={this.handleFlagCell(index)}
        key={index}
      />
    );
  }

  render() {
    const { game, loading } = this.state;
    if (loading) {
      return <main>Loading...</main>
    }

    let seconds;
    if (game.status !== "active") {
      seconds = moment(game.endTime).unix() - moment(game.startTime).unix();
    } else {
      seconds = moment().unix() - moment(game.startTime).unix();
    }
    return(
      <main className="game">
        <header>
          <p>Mines: {game.minesAmount}</p>
          <p>{game.status}</p>
          <Timer stop={game.status !== "active"} seconds={seconds}/>
        </header>
        <div className="board" ref={this.boardRef}>
          {game.currentCells.map((cell, index) => this.renderCell(cell, index))}
        </div>
      </main>
    );
  }
}
