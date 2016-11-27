import Immutable from 'immutable';

export const $$initialState = Immutable.fromJS({
  data: [],
});

export default function settingsReducer($$state = $$initialState, action = null) {
  const { type, comment, comments, error } = action;
  return $$state;
}
