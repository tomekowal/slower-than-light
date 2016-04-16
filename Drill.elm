module Drill (Model, init, Action(..), update, view) where

import Html exposing (Html, text, div, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

type alias Model =
  { metal : Int
  , counter : Maybe Int
  , work_time : Int
  }

init : Int -> Int -> Model
init metal work_time =
  { metal = metal
  , counter = Nothing
  , work_time = work_time
  }

type Action
  = Tick
  | DeployDrill

update : Action -> Model -> Model
update action model =
  case action of
    DeployDrill ->
      { model | counter = Just model.work_time }
    Tick ->
      case model.counter of
        Just 0 -> { model
                  | metal = model.metal + 1
                  , counter = Nothing }
        Nothing -> model
        Just time -> { model
                     | counter = Just (time - 1) }

buttonStyle =
  style
    [ ("position", "relative")
    , ("text-align", "center")
    , ("border", "1px solid black")
    , ("width", "100px")
    , ("margin-bottom", "5px")
    , ("padding", "5px 10px")
    , ("cursor", "pointer")
    , ("-webkit-touch-callout", "none")
    , ("-webkit-user-select", "none")
    , ("-khtml-user-select", "none")
    , ("-moz-user-select", "none")
    , ("-ms-user-select", "none")
    , ("user-select", "none")]

view : Signal.Address Action -> Model -> Html
view address model =
    div []
        [ text ("metal: " ++ toString model.metal)
        , text (toString model.counter)
        , div [ onClick address DeployDrill, buttonStyle ] [ text "deploy the drill" ]
        ]
