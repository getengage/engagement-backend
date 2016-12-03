import React from 'react';
import { connect } from 'react-redux';

const stateToProps = (state) => {
  return state.store.toJS()
}

const dispatchToProps = (dispatch) => ({
  addKey: (key) => {
    dispatch({type: 'ADD_KEY' , key})
  }
});

var SettingsForm = React.createClass({
  componentDidMount: function() {
    if (this.refs.modal && !("zfPlugin" in $(this.refs.modal).data())) {
      new Foundation.Reveal($(this.refs.modal));
    }
  },

  inputVal: function() {
    return (this.state && 'inputVal' in this.state) ? this.state.inputVal : this.props.inputVal;
  },

  handleTextChange: function(e) {
    this.setState({inputVal: e.target.value});
  },

  apiKeySubmitted: function(data) {
    this.props.addKey(data);
    $(this.refs.modal).foundation('close');
    this.setState({inputVal: ''});
  },

  doSubmit: function (e) {
    e.preventDefault();
    $.post(this.props.source, {
      user_id: this.props.user_id,
      name: this.state.inputVal
    }).then(this.apiKeySubmitted);
  },

  render: function() {
    return (
      <div className="SettingsForm">
        <hr />
        <div className="clearfix">
          <div>
            <div className="float-left">
              <a className="button" data-open="api_key_new">Generate API Key</a>
            </div>
          </div>
          <div ref="modal" className="reveal fast" data-animation-in="slide-in-down" data-animation-out="fade-out" id="api_key_new" data-reveal>
          <form action={this.props.source} method="post" className="todoForm form-horizontal" onSubmit={this.doSubmit}>
            <fieldset>
              <div className="form-group">
                <label htmlFor="name">API Key Name</label>
                <input name="name" onChange={this.handleTextChange} type="text"/>
                <input className={"button close-reveal-modal " + (this.inputVal() === '' ? 'disabled' : 'enabled')} type="submit"/>
              </div>
            </fieldset>
          </form>
          </div>
        </div>
      </div>
    );
  }
});

export default connect(stateToProps, dispatchToProps)(SettingsForm);
