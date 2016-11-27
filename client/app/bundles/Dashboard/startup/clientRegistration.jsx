import React from 'react';
import ReactOnRails from 'react-on-rails';
import SettingsContainer from '../containers/Settings';
import settingsStore from '../store/Settings';

ReactOnRails.register({ SettingsContainer });

ReactOnRails.registerStore({ settingsStore });

ReactOnRails.setOptions({
 traceTurbolinks: true,
});
