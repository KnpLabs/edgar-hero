import 'react-hyperscript-helpers': { div, h }
import './Landscape': { Landscape }
import './App.sass': style
import './Game': { Game }

export App = (props) ->
  div '#app' [
    h Game, {} [
      h Landscape
    ]
  ]
