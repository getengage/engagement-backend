import React from 'react';

var SettingsItem = React.createClass({

  removeNode: function (e) {
    e.preventDefault();
    $.ajax({
      url: this.props.source,
      type: 'DELETE'
    }).then(this.props.removeNode);
  },

  render: function() {
    return (
      <tr>
        <td>{this.props.nodeId}</td>
        <td>{this.props.name}</td>
        <td>{this.props.uuid}</td>
        <td>
          <button type="button" className="btn btn-xs btn-danger img-circle" onClick={this.removeNode}>&#xff38;</button>
        </td>
      </tr>
    );
  }
});

export default SettingsItem;
