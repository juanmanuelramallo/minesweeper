import React, { Component } from "react";
import moment from "moment";

export default class Timer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      seconds: props.seconds ? props.seconds : 0
    }
  }

  componentDidMount() {
    setInterval(this.increment, 1000);
  }

  increment = () => {
    if (this.props.stop) {
      clearInterval(this.increment);
      return;
    }

    this.setState(state => ({
      seconds: state.seconds + 1
    }))
  }

  render() {
    const { seconds } = this.state;
    const duration = moment.duration(seconds * 1000);
    return(
      <p>{moment.utc(duration.as("milliseconds")).format("mm:ss")}</p>
    );
  }
}
