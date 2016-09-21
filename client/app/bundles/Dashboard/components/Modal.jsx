import React, { PropTypes } from 'react';
import classNames from 'classnames';

var Modal = React.createClass({

  propTypes: {
    url: React.PropTypes.string.isRequired,
  },

  getInitialState: function() {
    return {
      visibility: false
    };
  },
  componentDidMount: function() {
    document.addEventListener('keyup', this.handleDocumentKeyUp);
    setTimeout(function() {
      this.setState({
        'visibility': true
      });
    }.bind(this), 0);
  },

  componentWillUnmount: function() {
    document.removeEventListener('keyup', this.handleDocumentKeyUp);
  },

  hide: function() {
    window.history.back();
  },

  render: function() {
    var classes = {
      "reveal-modal": true,
      //"completed": true,
      //"open": this.state.visibility,
      "animatable": true,
       "slide-in-right": true,
       'active': this.state.visibility
    };
    var style = {
      display: "block",
      "-webkit-transform-origin": "0px 0px",
      "-webkit-transform": "scale(1, 1)",
      visibility: "visible",
      top: "100px"
    };
    return (
      <div>
        <div onClick={this.handleBackdropClick}  className="reveal-modal-bg" style={{opacity: 1, display: "block", 'zIndex': '300'}}></div>
        <div className={classNames(classes)}>
          {this.props.children}
        </div>
      </div>
    );
  },

  handleBackdropClick: function (e) {
    if (e.target !== e.currentTarget) {
      return;
    }
    this.hide();
    //this.props.onRequestHide();
  },

  handleDocumentKeyUp: function (e) {
    if (e.keyCode === 27) {
      this.hide();
    }
  }
});

export default Modal;