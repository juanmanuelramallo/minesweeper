import React, { Component } from 'react';

import SignUp from "./components/SignUp";
import User from "./components/User";
import Games from "./components/Games";

import { init } from "./client/Minesweeper";
import { getCurrentUserUuid } from "./services/CurrentUserService";

import './App.css';

class App extends Component {
  constructor() {
    super();
    this.state = {
      user: null,
      selectedGame: null
    }
  }

  componentDidMount() {
    if (getCurrentUserUuid()) {
      console.log("hay uuid");
      init()
        .then(response => {
          const user = response.data;
          this.setState({ user });
        })
    }
  }

  handleData = (data) => {
    this.setState({
      ...data
    })
  }

  render() {
    const { user, selectedGame } = this.state;
    return (
      <main className="minesweeper">
        <h1 className="minesweeper-titke">Minesweeper</h1>

        { !user &&
          <SignUp handleData={this.handleData}/>
        }

        { user &&
          <User user={user} />
        }

        { user && !selectedGame &&
          <Games games={user.games} />
        }
      </main>
    );
  }
}

export default App;
