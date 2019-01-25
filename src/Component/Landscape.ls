import 'react-hyperscript-helpers': { div, h }
import 'ramda': { map, range, append }
import './Landscape.sass': style
import './Spotlight': { Spotlight }

export Landscape = (props) ->
  div '#landscape' [
    div '.moon' map do
      -> div '.crater'
      range 0 7
    h Spotlight
    div '.stars' map do
      -> div '.star'
      range 0 8
    div '.clouds' [
      cloud 3
      cloud 2
      cloud 3
      cloud 2
    ]
    h City
  ]

cloud = (amountOfMist = 3) ->
  div ".cloud.of#{amountOfMist}" map do
    -> div '.mist'
    range 0 amountOfMist

City = ->
  div '.city' [
    div '.tower.one' [
      div '.head' [
        div '.pic'
        div '.block'
        div '.block.larger'
        div '.block.full-size'
      ]
      h TowerBody, { numberOfFloor: 6, numberOfWindow: 3 }
    ]
    div '.tower.two' [
      div '.head' [
        div '.block.full-size'
      ]
      h TowerBody, { numberOfWindow: 3, numberOfFloor: 3 }
    ]

    div '.tower.three' [
      div '.head' [
        div '.block.full-size'
      ]
      h TowerBody, { numberOfFloor: 8, numberOfWindow: 6 }
    ]

    div '.tower.four' [
      div '.head' [
        div '.dome'
        div '.block.larger'
        div '.block.full-size'
      ]
      h TowerBody, { numberOfFloor: 5, numberOfWindow: 3, separator: 1 }
    ]

    div '.tower.five' [
      div '.head' [
        div '.block'
        div '.block.larger'
        div '.block.full-size'
      ]
      h TowerBody, { numberOfFloor: 4, numberOfWindow: 2 }
    ]

    div '.tower.six' [
      div '.head' [
        div '.pic'
        div '.block'
        div '.block.larger'
        div '.block.full-size'
      ]
      h TowerBody, { numberOfFloor: 7, numberOfWindow: 4 }
    ]
  ]

TowerBody = ({
  numberOfFloor = 3
  numberOfWindow = 3
  separator = 0
}) ->
  switch separator
  | 0 =>
    div '.body' do
      lightEffect = div '.light-effect'
      append lightEffect, map do
        -> div '.floor' map do
          -> div '.window'
          range 0 numberOfWindow
        range 0 numberOfFloor
  | otherwise =>
    div '.body' do
      lightEffect = div '.light-effect'
      append lightEffect, map do
        (x) -> switch x
          | separator => div '.separator'
          | otherwise =>
            div '.floor' map do
              -> div '.window'
              range 0 numberOfWindow
        range 0 (numberOfFloor + 1)
