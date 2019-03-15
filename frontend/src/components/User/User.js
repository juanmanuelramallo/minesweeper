import React, { Component } from 'react';
import moment from "moment";
import { removeCurrentUserUuid } from "../../services/CurrentUserService";
import "./User.css";

export default class SignUp extends Component {
  handleLogout = () => {
    removeCurrentUserUuid();
    this.props.handleData({
      user: null,
      selectedGameId: null
    });
  }

  render() {
    return (
      <div className="user">
        <p className="user-name">{ this.props.user.name }</p>
        <p className="user-created-at">Since { moment(this.props.user.createdAt).format("LL") }</p>
        <button type="button" onClick={this.handleLogout}>Logout</button>
      </div>
    );
  }
}
