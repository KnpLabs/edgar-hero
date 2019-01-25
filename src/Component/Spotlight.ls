import 'react-hyperscript-helpers': { div }
import 'ramda': { map, range, append }
import './Spotlight.sass': style

export Spotlight = (props) ->
  div '#spotlight' [
    div '.ray'
    div '.paw' do
      palm = div '.palm'
      append palm, map do
        (x) -> div ".digit.digit-#{x}"
        range 1 5
  ]
