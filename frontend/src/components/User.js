import React, { Component } from 'react';

export default class SignUp extends Component {
  render() {
    return (
      <div className="user">
        <p className="user-name">{ this.props.user.name }</p>
        <p className="user-created-at">Since { this.props.user.createdAt }</p>
      </div>
    );
  }
}
