import 'react-hyperscript-helpers': { h }
import 'ramda': { always, assoc }
import 'react': { createContext, useReducer, useEffect }

export TICK = Symbol 'tick'
export JUMP = Symbol 'jump'
export START = Symbol 'start'
export STOP = Symbol 'stop'

export tick = always { type: TICK }
export jump = always { type: JUMP }
export start = always { type: START }
export stop = always { type: STOP }

export initialState =
  running: false
  jumping: false

export reducer = (action, state) ->
  switch action.type
  | START => assoc 'running' true state
  | STOP => assoc 'running' false state
  | TICK => state
  | JUMP => assoc 'jumping' true state
  | otherwise => state

export GameContext = createContext { state: initialState, dispatch: always null }

gameLoop = (dispatch, e) -->
  dispatch tick!
  requestAnimationFrame gameLoop dispatch

export Game = ({
  children
}) ->
  [ state, dispatch ] = useReducer reducer, initialState

  useEffect do
    !-> requestAnimationFrame gameLoop dispatch
    [ state.running ]

  h do
    GameContext.Provider
    { value: { state: state, dispatch: dispatch } }
    [ children ]
