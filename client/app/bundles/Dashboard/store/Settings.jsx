import { compose, createStore, applyMiddleware } from 'redux';
import createLogger from 'redux-logger';
import allReducers from '../reducers';
import { $$initialState } from '../reducers/settingsReducer';

export default (props, railsContext) => {
  const { user_id, source, data } = props;
  const initialState = {
    store: $$initialState.merge({ user_id, source, data }),
    railsContext,
  };
  const loggerMiddleware = createLogger();
  const composedStore = compose(applyMiddleware(loggerMiddleware));
  return composedStore(createStore)(allReducers, initialState);
};
