import 'react-hyperscript-helpers': { h }
import 'ramda': { always, assoc, evolve, any, values, equals, prop }
import 'react': { createContext, useReducer, useEffect }

export TICK = Symbol 'tick'
export JUMP = Symbol 'jump'
export START = Symbol 'start'
export STOP = Symbol 'stop'
export PRESS_LEFT = Symbol 'press left'
export RELEASE_LEFT = Symbol 'press left'
export PRESS_RIGHT = Symbol 'press RIGHT'
export RELEASE_RIGHT = Symbol 'press RIGHT'
export PRESS_UP = Symbol 'press UP'
export RELEASE_UP = Symbol 'press UP'
export PRESS_DOWN = Symbol 'press DOWN'
export RELEASE_DOWN = Symbol 'press DOWN'

export tick = always { type: TICK }
export jump = always { type: JUMP }
export start = always { type: START }
export stop = always { type: STOP }
export pressLeft = always { type: PRESS_LEFT }
export pressRight = always { type: PRESS_RIGHT }
export pressUp = always { type: PRESS_UP }
export pressDown = always { type: PRESS_DOWN }
export releaseLeft = always { type: RELEASE_LEFT }
export releaseRight = always { type: RELEASE_RIGHT }
export releaseUp = always { type: RELEASE_UP }
export releaseDown = always { type: RELEASE_DOWN }

export initialState =
  running: false
  jumping: false
  speedModifier: 0
  keys:
    left: false
    right: false
    up: false
    down: false
  position:
    x: 0
    y: 0

down = (state) ->
  if state.keys.down
  then evolve {
    position: assoc 'y' state.position.y + (1 * state.speedModifier)
  } state
  else state

up = (state) ->
  if state.keys.up
  then evolve {
    position: assoc 'y' state.position.y - (1 * state.speedModifier)
  } state
  else state

left = (state) ->
  if state.keys.left
  then evolve {
    position: assoc 'x' state.position.x - (1 * state.speedModifier)
  } state
  else state

right = (state) ->
  if state.keys.right
  then evolve {
    position: assoc 'x' state.position.x + (1 * state.speedModifier)
  } state
  else state

handleSpeedModifier = (state) ->
  if state.keys |> values |> any equals true
  then
    newModifier = state.speedModifier + 0.1
    if newModifier > 20 then newModifier = 20
    assoc 'speedModifier' newModifier, state
  else
    newModifier = state.speedModifier - 0.1
    if newModifier < 1 then newModifier = 1
    assoc 'speedModifier' newModifier, state

export reducer = (state, action) ->
  switch action.type
  | START => assoc 'running' true state
  | STOP => assoc 'running' false state
  | TICK => (up >> down >> left >> right >> handleSpeedModifier) state
  | JUMP => assoc 'jumping' true state
  | PRESS_LEFT => evolve { keys: assoc 'left' true } state
  | PRESS_RIGHT => evolve { keys: assoc 'right' true } state
  | PRESS_UP => evolve { keys: assoc 'up' true } state
  | PRESS_DOWN => evolve { keys: assoc 'down' true } state
  | RELEASE_LEFT => evolve { keys: assoc 'left' false } state
  | RELEASE_RIGHT => evolve { keys: assoc 'right' false } state
  | RELEASE_UP => evolve { keys: assoc 'up' false } state
  | RELEASE_DOWN => evolve { keys: assoc 'down' false } state
  | otherwise => state

export GameContext = createContext { state: initialState, dispatch: always null }

gameLoop = (dispatch, e) -->
  dispatch tick!
  requestAnimationFrame gameLoop dispatch

handleKeyDown = (dispatch, e) -->
  switch e.code
  | 'ArrowLeft' => dispatch pressLeft!
  | 'ArrowUp' => dispatch pressUp!
  | 'ArrowDown' => dispatch pressDown!
  | 'ArrowRight' => dispatch pressRight!

handleKeyUp = (dispatch, e) -->
  switch e.code
  | 'ArrowLeft' => dispatch releaseLeft!
  | 'ArrowUp' => dispatch releaseUp!
  | 'ArrowDown' => dispatch releaseDown!
  | 'ArrowRight' => dispatch releaseRight!

export Game = ({
  children
}) ->
  [ state, dispatch ] = useReducer reducer, initialState

  useEffect do
    !-> requestAnimationFrame gameLoop dispatch
    [ state.running ]

  useEffect ->
    downEff = handleKeyDown dispatch
    upEff = handleKeyUp dispatch
    document.addEventListener 'keydown' downEff
    document.addEventListener 'keyup' upEff
    !->
      document.removeEventListener 'keydown' downEff
      document.removeEventListener 'keyup' upEff

  h do
    GameContext.Provider
    { value: { state: state, dispatch: dispatch } }
    [ children ]
