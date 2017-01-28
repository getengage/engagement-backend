import Immutable from 'immutable';

export const $$initialState = Immutable.fromJS({
  data: [],
});

export default function settingsReducer(state = $$initialState, action = null) {
  const { type, key } = action;

  switch (type) {
    case 'ADD_KEY':
      return state.updateIn(['data'], arr =>
        arr.push(Immutable.Map(key))
      )
    case 'REMOVE_KEY':
      return state.updateIn(['data'], arr =>
        arr.filter(entry => entry.get('id') !== key.id)
      )
    default:
      return state
  }
}
