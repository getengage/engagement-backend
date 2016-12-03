import React from 'react';
import { connect } from 'react-redux';
import SettingsItem from './SettingsItem';
import Notifications from 'react-notification-system-redux';

const stateToProps = (state) => {
  return state.store.toJS()
};

const dispatchToProps = (dispatch) => ({
  removeKey: (key) => {
    dispatch(Notifications.success({message: 'Key Removed', position: 'br'}))
    dispatch({type: 'REMOVE_KEY', key})
  },
});

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

  render: function() {
    var listNodes = this.props.data.map(function (listItem, i) {
      return (
        <SettingsItem
          key={listItem.id}
          nodeId={listItem.id}
          name={listItem.name}
          uuid={listItem.uuid}
          removeNode={this.props.removeKey.bind(this)}
          source={listItem.source} />
      );
    }, this);

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

export default connect(stateToProps, dispatchToProps)(SettingsTable);
