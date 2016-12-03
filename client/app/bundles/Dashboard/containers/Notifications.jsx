import React from 'react';
import ReactOnRails from 'react-on-rails';
import { Provider } from 'react-redux';
import Notifications from '../components/Notifications';

export default (_props, _railsContext) => {
  const store = ReactOnRails.getStore('SettingsStore');

  return (
    <Provider store={store}>
      <Notifications />
    </Provider>
  );
};
