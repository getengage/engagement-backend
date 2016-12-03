import settingsReducer from './settingsReducer';
import railsContext from './railsContextReducer';
import { combineReducers } from 'redux';
import { reducer as notifications } from 'react-notification-system-redux';

const allReducers = combineReducers({
  store: settingsReducer,
  notifications,
  railsContext,
});

export default allReducers;