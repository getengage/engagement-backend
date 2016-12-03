import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import Notifications from 'react-notification-system-redux';

class NotificationsComponent extends React.Component {

  render() {
    const {notifications} = this.props;

    const style = {
      NotificationItem: {
        DefaultStyle: {
          margin: '10px 5px 2px 1px'
        },
        success: {
          color: 'green'
        }
      }
    };

    return (
      <Notifications
        notifications={notifications}
        style={style}
      />
    );
  }
}

NotificationsComponent.contextTypes = {
  store: PropTypes.object
};

NotificationsComponent.propTypes = {
  notifications: PropTypes.array
};

export default connect(
  state => ({ notifications: state.notifications })
)(NotificationsComponent);