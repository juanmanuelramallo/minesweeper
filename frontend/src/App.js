import React, { Component } from 'react';

import SignUp from "./components/SignUp";
import User from "./components/User/User";
import Games from "./components/Games/Games";
import Game from "./components/Game/Game";

import { user } from "./client/Minesweeper";
import { getCurrentUserUuid } from "./services/CurrentUserService";

import './App.css';

class App extends Component {
  constructor() {
    super();
    this.state = {
      user: null,
      selectedGameId: null
    }
  }

  componentDidMount() {
    if (getCurrentUserUuid()) {
      this.fetchUser();
    }
  }

  fetchUser() {
    user()
      .then(response => {
        const user = response.data;
        this.setState({ user, selectedGameId: null });
      })
  }

  handleData = (data) => {
    this.setState({
      ...data
    })
  }

  clearSelectedGame = () => {
    this.fetchUser();
  }

  render() {
    const { user, selectedGameId } = this.state;
    return (
      <main className="minesweeper">
        <h1>Minesweeper</h1>

        { !user &&
          <SignUp handleData={this.handleData}/>
        }

        { user &&
          <User user={user} handleData={this.handleData} />
        }

        { user && !selectedGameId &&
          <Games games={user.games} handleData={this.handleData} />
        }

        { selectedGameId &&
          <>
            <button type="button" onClick={this.clearSelectedGame}>Go back</button>
            <Game selectedGameId={selectedGameId} handleData={this.handleData} />
          </>
        }
      </main>
    );
  }
}

export default App;
