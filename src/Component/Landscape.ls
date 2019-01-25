import 'react-hyperscript-helpers': { div, h }
import 'ramda': { map, range }
import './Landscape.sass': style
import './Spotlight': { Spotlight }

export Landscape = (props) ->
  div '#landscape' [
    div '.moon' map do
      -> div '.crater'
      range 1 8
    h Spotlight
  ]
