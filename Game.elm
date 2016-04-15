module Game (init, update, view, Action(..)) where

import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Effects exposing (Effects, Never)
import Drill

type alias Model =
  { drill : Drill.Model }

init : Int -> Int -> (Model, Effects Action)
init metal work_time =
  ({ drill = Drill.init metal work_time }, Effects.none)

type Action
  = Tick
  | Drill Drill.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
      Tick ->
        ({ model |
             drill = Drill.update Drill.Tick model.drill
         }, Effects.none)
      Drill act ->
        ({ model |
             drill = Drill.update act model.drill
         }, Effects.none)

view : Signal.Address Action -> Model -> Html
view address model =
  Drill.view (Signal.forwardTo address Drill) model.drill

