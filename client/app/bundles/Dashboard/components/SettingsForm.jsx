import React, { PropTypes } from 'react';

var SettingsForm = React.createClass({
  getInitialState: function() {
    return {new_api_key_name: ''};
  },
  componentDidMount: function() {
    if (this.refs.modal && !("zfPlugin" in $(this.refs.modal).data())) {
      new Foundation.Reveal($(this.refs.modal));
    }
  },
  handleTextChange: function(e) {
    this.setState({new_api_key_name: e.target.value});
  },
  apiKeySubmitted: function(data) {
    this.props.onApiKeyNewSubmit(data);
    $(this.refs.modal).foundation('close');
    this.setState({new_api_key_name: ""});
  },
  doSubmit: function (e) {
    e.preventDefault();
    $.post(this.props.source, {
      user_id: this.props.userId,
      name: this.state.new_api_key_name
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
                <input name="name" value={this.state.new_api_key_name} onChange={this.handleTextChange} type="text"/>
                <input className={"button close-reveal-modal " + (this.state.new_api_key_name === "" ? 'disabled' : 'enabled')} type="submit"/>
              </div>
            </fieldset>
          </form>
          </div>
        </div>
      </div>
    );
  }
});

export default SettingsForm;