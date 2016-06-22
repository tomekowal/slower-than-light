import Html.App as App
import Html exposing (Html, text, div, button)
import Html.App exposing (map)
import Time exposing (millisecond, Time)
import CounterButton

main : Program Never
main =
  App.program { init = init 0 200
              , view = view
              , update = update
              , subscriptions = subscriptions }

type alias Model =
  { drill : CounterButton.Model }

init : Float -> Float -> (Model, Cmd Msg)
init metal work_time =
  ({ drill = CounterButton.init "metal" work_time "Deploy the drill"}, Cmd.none)

type Msg
  = Tick Time
  | CounterButton CounterButton.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
    case action of
      Tick time ->
        ({ model |
             drill = CounterButton.update CounterButton.Tick model.drill
         }, Cmd.none)
      CounterButton act ->
        ({ model |
             drill = CounterButton.update act model.drill
         }, Cmd.none)

view : Model -> Html Msg
view model =
  map CounterButton (CounterButton.view model.drill)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every (20 * millisecond) Tick
