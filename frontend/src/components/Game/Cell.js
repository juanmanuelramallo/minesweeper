import React, { Component } from "react";

export default class Cell extends Component {
  handleContextMenu = (e) => {
    e.preventDefault();
    this.props.handleFlagCell();
  }

  renderContent() {
    const { cell } = this.props;
    if (cell === -1 || cell === 0) {
      return ""
    } else if (cell === "flag") {
      return "🚩";
    } else if (cell === null) {
      return "💣";
    } else if (cell > 0) {
      return cell;
    }
  }

  render() {
    const { cell } = this.props;
    const classes = `${cell === 0 ? "opened" : ""} ${cell > 0 ? "opened" : ""}`;
    return(
      <button
        className={classes}
        type="button"
        onClick={this.props.handleOpenCell}
        onContextMenu={this.handleContextMenu}
        disabled={this.props.disabled}
      >
        {this.renderContent()}
      </button>
    );
  }
}
