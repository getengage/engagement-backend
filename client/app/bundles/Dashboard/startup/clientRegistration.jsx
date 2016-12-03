import React from 'react';
import ReactOnRails from 'react-on-rails';
import Notifications from '../containers/Notifications';
import SettingsContainer from '../containers/Settings';
import SettingsStore from '../store/Settings';

ReactOnRails.register({ Notifications });
ReactOnRails.register({ SettingsContainer });
ReactOnRails.registerStore({ SettingsStore });

ReactOnRails.setOptions({
 traceTurbolinks: true,
});
