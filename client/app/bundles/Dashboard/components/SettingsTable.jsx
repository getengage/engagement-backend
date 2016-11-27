import React from 'react';
import { connect } from 'react-redux';
import SettingsItem from './SettingsItem';

function stateToProps(state) {
  return {
    data: state.$$settingsStore.get('data')
  }
}

var SettingsTable = React.createClass({
  componentDidMount: function() {
    if (this.refs.table && !$.fn.DataTable.fnIsDataTable(this.refs.table)) {
      return $(this.refs.table).dataTable({
        "bFilter": false,
        "bLengthChange": false,
        "bInfo": false,
        "bPaginate": false
      });
    }
  },
  removeNode: function (nodeId) {
    this.props.removeNode(nodeId);
    return;
  },
  render: function() {
    debugger;
    var listNodes = this.props.data.map(function (listItem) {
      return (
        <SettingsItem key={listItem.id} nodeId={listItem.id} name={listItem.name} uuid={listItem.uuid} removeNode={this.removeNode} source={listItem.source} />
      );
    },this);
    return (
      <table id="settings-table" ref="table">
        <thead>
          <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Api Key</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {listNodes}
        </tbody>
      </table>
    );
  }
});

export default connect(stateToProps)(SettingsTable);
