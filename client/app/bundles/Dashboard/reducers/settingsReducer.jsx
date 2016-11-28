import Immutable from 'immutable';

export const $$initialState = Immutable.fromJS({
  data: [],
});

export default function settingsReducer(state = $$initialState, action = null) {
  const { type, key } = action;

  switch (type) {
    case 'ADD_KEY':
      return {
        store: state.store.updateIn(['data'], arr =>
          arr.push(Immutable.Map(key))
        ),
        railsContext: state.railsContext,
      }
    case 'REMOVE_KEY':
      return {
        store: state.store.updateIn(['data'], arr =>
          arr.filter(entry => entry.get('id') !== key.id)
        ),
        railsContext: state.railsContext,
      }
    default:
      return state
  }
}
