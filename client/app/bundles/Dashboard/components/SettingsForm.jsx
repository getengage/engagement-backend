import React, { PropTypes } from 'react';
import _ from 'lodash';

var SettingsForm = React.createClass({
  doSubmit: function (e) {
    e.preventDefault();
    this.props.onTaskSubmit('test');
    return;
  },
  render: function() {
    return (
      <div className="commentForm vert-offset-top-2">
        <hr />
        <div className="clearfix">
          <form className="todoForm form-horizontal" onSubmit={this.doSubmit}>
            <div>
              <div className="float-left">
                <input type="submit" value="Generate API Key" className="button" />
              </div>
            </div>
          </form>
        </div>
      </div>
    );
  }
});

export default SettingsForm;