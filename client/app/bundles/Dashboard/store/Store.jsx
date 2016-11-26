import { createStore } from 'react-redux';
import reducers, { initialStates } from '../reducers';

export default (props, railsContext) => {
  const initialState = {
    $$settingsStore: $$initialState,
    railsContext,
  };
  return createStore(reducers, initialState);
};
