import 'react-hyperscript-helpers': { div }
import 'react': { createElement }
import './Game': { GameContext }
import './Edgar.sass': style

export Edgar = ->
  createElement GameContext.Consumer, {}, ({ state }) ->
    div '.edgar' { style: { transform: "translate(#{state.position.x}px, #{state.position.y}px)" } } [
      div '.edcape'
      div '.ears' [
        div '.leftear'
        div '.rightear'
      ]
      div '.feet' [
        div '.leftfoot'
        div '.rightfoot'
      ]
      div '.arms' [
        div '.arm.left'
        div '.arm.right'
      ]
      div '.edbody' [
        div '.mask'
        div '.eyes' [
          div '.lefteye'
          div '.righteye'
        ]
        div '.nose' [
          div '.whiskers'
        ]
        div '.mouth'
      ]
    ]
