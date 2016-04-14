module Drill (Model, init, Action(..), update, view) where

import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)

type alias Model =
  { metal : Int
  , counter : Int
  }

init : Int -> Int -> Model
init metal counter =
  { metal = metal
  , counter = counter
  }

type Action
  = Tick
  | DeployDrill

update : Action -> Model -> Model
update action model =
  case action of
    DeployDrill ->
      { model | counter = 5 }
    Tick ->
      case model.counter of
        1 -> { model
               | metal = model.metal + 1
               , counter = 0 }
        0 -> model
        time -> { model
                  | counter = time - 1 }

view : Signal.Address Action -> Model -> Html
view address model =
    div []
        [ text ("metal: " ++ toString model.metal)
        , text (toString model.counter)
        , button [ onClick address DeployDrill ] [ text "deploy the drill" ]
        ]
