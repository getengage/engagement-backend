import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import createLogger from 'redux-logger';
import reducers, { $$initialState } from '../reducers/settingsReducer';

export default (props, railsContext) => {
  const initialState = {
    $$settingsStore: $$initialState,
    railsContext,
  };
  const loggerMiddleware = createLogger();
  const composedStore = compose(applyMiddleware(loggerMiddleware));
  return composedStore(createStore)(reducers, initialState);
};
