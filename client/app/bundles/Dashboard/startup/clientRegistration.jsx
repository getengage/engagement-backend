import React from 'react';
import ReactOnRails from 'react-on-rails';
import SettingsContainer from '../containers/Settings';

const SettingsContainerApp = (props) => (
  <SettingsContainer {...props} />
);

ReactOnRails.register({ SettingsContainerApp });

ReactOnRails.setOptions({
 traceTurbolinks: true,
});
