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
    { drill_button : CounterButton.Model
    , drill_max_work_time : Int
    , drill_current_work_time : Maybe Int
    , metal : Int
    }

init : Int -> Int -> (Model, Cmd Msg)
init metal work_time =
    ({ drill_button = CounterButton.init "Deploy the drill"
     , drill_current_work_time = Nothing
     , drill_max_work_time = work_time
     , metal = metal
     }, Cmd.none)

type Msg
    = Tick Time
    | CounterButton CounterButton.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
    case action of
        Tick time ->
            case model.drill_current_work_time of
                Nothing -> ( model, Cmd.none )
                Just counter ->
                    case counter == model.drill_max_work_time of
                        True ->
                            ({ model | drill_current_work_time = Nothing, metal = model.metal + 1 }
                            , Cmd.none)
                        False ->
                            ({ model | drill_current_work_time = Just (counter + 1) }
                            , Cmd.none)
        CounterButton CounterButton.Click ->
            ({ model |
                   drill_current_work_time = Just 0
             }, Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [map CounterButton (CounterButton.view model.drill_button model.drill_current_work_time model.drill_max_work_time)
        , label "metal" model]

label : String -> Model-> Html Msg
label caption model =
    div [] [text(caption ++ ": " ++ (toString model.metal))]

subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (20 * millisecond) Tick
