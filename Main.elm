import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import StartApp
import Time exposing (..)
import Signal exposing (Signal, map)
import Effects exposing (Effects, Never)
import Drill

ticks : Signal Action
ticks =
  Signal.map (\(timeStamp, tick) -> Tick) (timestamp (every second))

app =
  StartApp.start { init = init 0 0
                 , view = view
                 , update = update
                 , inputs = [ticks] }

main =
  app.html

type alias Model =
  { drill : Drill.Model }

init : Int -> Int -> (Model, Effects Action)
init metal counter =
  ( { drill = Drill.init metal counter }, Effects.none )

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
