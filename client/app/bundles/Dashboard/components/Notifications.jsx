import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import Notifications from 'react-notification-system-redux';

const stateToProps = (state) => {
  return {
    notifications: state.notifications
  }
};

const dispatchToProps = (dispatch) => ({
  notify: (msg) => {
    dispatch(Notifications.success(msg))
  },
});

class NotificationsComponent extends React.Component {

  componentDidMount() {
    const msg = this.props.notifications.shift();
    if (msg) setTimeout(this.props.notify(msg), 1000);
  }

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

export default connect(stateToProps, dispatchToProps)(NotificationsComponent);
