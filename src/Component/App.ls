import 'react-hyperscript-helpers': { div, h }
import './Landscape': { Landscape }
import './App.sass': style

export App = (props) ->
  div '#app' [
    h Landscape
  ]
