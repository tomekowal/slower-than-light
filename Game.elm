module Game exposing (init, update, view, Msg(..), subscriptions) 

import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Html.App exposing (map)
import Time exposing (millisecond, Time)
import Drill

type alias Model =
  { drill : Drill.Model }

init : Float -> Float -> (Model, Cmd Msg)
init metal work_time =
  ({ drill = Drill.init metal work_time }, Cmd.none)

type Msg
  = Tick Time
  | Drill Drill.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
    case action of
      Tick time ->
        ({ model |
             drill = Drill.update Drill.Tick model.drill
         }, Cmd.none)
      Drill act ->
        ({ model |
             drill = Drill.update act model.drill
         }, Cmd.none)

view : Model -> Html Msg
view model =
  map Drill (Drill.view model.drill)

subscriptions model =
  Time.every (20 * millisecond) Tick
