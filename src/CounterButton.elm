module CounterButton exposing (Model, init, Msg(..), update, view)

import Html exposing (Html, text, div, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

type alias Model =
  { resource : Float
  , resource_name : String
  , counter : Maybe Float
  , work_time : Float
  , button_text : String
  }

init : String -> Float -> String -> Model
init resource_name work_time button_text =
  { resource = 0
  , resource_name = resource_name
  , counter = Nothing
  , work_time = work_time
  , button_text = button_text
  }

type Msg
  = Tick
  | Click

update : Msg -> Model -> Model
update action model =
  case action of
    Click ->
      { model | counter = Just model.work_time }
    Tick ->
      case model.counter of
        Just 0 -> { model
                  | resource = model.resource + 1
                  , counter = Nothing }
        Nothing -> model
        Just time -> { model
                     | counter = Just (time - 1) }

buttonStyle : String -> Html.Attribute a
buttonStyle textColor =
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
    , ("user-select", "none")
    , ("color", textColor) ]

coolDownStyle : Float -> Html.Attribute b
coolDownStyle percent =
  style
    [ ("position", "absolute")
    , ("top", "0px")
    , ("left", "0px")
    , ("z-index", "-1")
    , ("height", "100%")
    , ("background-color", "#DDDDDD")
    , ("overflow", "hidden")
    , ("width", (toString percent) ++ "%")]

view : Model -> Html Msg
view model =
  case model.counter of
    Just counter ->
      divWithCounter model counter
    Nothing ->
      divWithoutCounter model

divWithoutCounter : Model -> Html Msg
divWithoutCounter model =
  div []
      [ text (label model)
      , div [ buttonStyle "black", onClick Click ]
            [ text "deploy the drill" ]]

divWithCounter : Model -> Float -> Html Msg
divWithCounter model counter =
  div []
      [ text (label model)
      , div [ buttonStyle "grey" ]
            [ text "deploy the drill" 
            , div [ coolDownStyle (counter / model.work_time * 100) ] []]
      ]

label : Model -> String
label model = model.resource_name ++ ": " ++ toString model.resource
