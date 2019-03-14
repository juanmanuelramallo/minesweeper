import React, { Component } from 'react';
import { createUser } from "../client/Minesweeper";
import { setCurrentUserUuid } from "../services/CurrentUserService";

export default class SignUp extends Component {
  constructor() {
    super();
    this.state = {
      name: ""
    }
  }

  handleName = (e) => {
    this.setState({
      name: e.target.value
    })
  }

  handleSubmit = (e) => {
    e.preventDefault();
    createUser(this.state.name)
      .then(response => {
        response.json().then(user => {
          setCurrentUserUuid(user.uuid);
          this.props.handleData({ user });
        })
      });
  }

  render() {
    return (
      <form className="sign-up" onSubmit={this.handleSubmit}>
        <div className="input-group">
          <label htmlFor="name">Name</label>
          <input type="text" id="name" name="user[name]" onChange={this.handleName}/>
        </div>

        <div className="sign-up__submit">
          <input type="submit" value="Let's play!"/>
        </div>
      </form>
    );
  }
}
