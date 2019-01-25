import 'react-hyperscript-helpers': { div }
import 'ramda': { map, range }
import './Landscape.sass': style

view = (props) ->
  div '#landscape' [
    div '.moon' map do
      -> div '.crater'
      range 1 8
  ]

export Landscape = view
