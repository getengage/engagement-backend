import React, { PropTypes } from 'react';
import SettingsTable from '../components/SettingsTable';
import SettingsForm from '../components/SettingsForm';

var SettingsContainer = React.createClass({
  getInitialState: function () {
    return {
      data: this.props.data
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
  handleSubmit: function (uuid) {
    var data = this.state.data;
    var id = this.state.data.length+1;
    data = data.concat([{id, uuid}]);
    this.setState({data});
  },
  render: function() {
    return (
      <div className="callout">
        <SettingsTable data={this.state.data} removeNode={this.handleNodeRemoval} />
        <SettingsForm onTaskSubmit={this.handleSubmit} />
      </div>
    );
  }
});

export default SettingsContainer;