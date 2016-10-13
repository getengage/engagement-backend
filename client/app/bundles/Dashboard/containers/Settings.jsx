import React, { PropTypes } from 'react';
import SettingsTable from '../components/SettingsTable';
import SettingsForm from '../components/SettingsForm';

var SettingsContainer = React.createClass({
  getInitialState: function () {
    return {
      data: this.props.data,
      source: this.props.source,
      userId: this.props.user_id
    };
  },
  handleNodeRemoval: function (nodeId) {
    var data = this.state.data;
    data = data.filter(function (el) {
      return el.id !== nodeId;
    });
    this.setState({data});
    return;
  },
  handleSubmit: function (newVals) {
    var data = this.state.data;
    newVals.id = this.state.data.length+1;
    data = data.concat([newVals]);
    this.setState({data});
  },
  render: function() {
    return (
      <div className="callout">
        <SettingsTable data={this.state.data} removeNode={this.handleNodeRemoval} />
        <SettingsForm userId={this.state.userId} source={this.state.source} onApiKeyNewSubmit={this.handleSubmit} />
      </div>
    );
  }
});

export default SettingsContainer;