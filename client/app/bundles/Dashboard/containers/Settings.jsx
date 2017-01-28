import React from 'react';
import ReactOnRails from 'react-on-rails';
import { Provider } from 'react-redux';
import SettingsTable from '../components/SettingsTable';
import SettingsForm from '../components/SettingsForm';

export default (_props, _railsContext) => {
  const store = ReactOnRails.getStore('SettingsStore');

  return (
    <Provider store={store}>
      <div className="callout">
        <SettingsTable />
        <SettingsForm />
      </div>
    </Provider>
  );
};
