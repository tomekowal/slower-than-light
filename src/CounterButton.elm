module CounterButton exposing (Model, Msg(..), init, view)

import Html exposing (Html, text, div, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

type alias Model =
  { button_text : String }

type Msg
  = Click

init : String -> Model
init button_text =
  { button_text = button_text }

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

view : Model -> Maybe Int -> Int-> Html Msg
view model counter max_work_time =
  case counter of
    Just counter ->
      divWithCounter model counter max_work_time
    Nothing ->
      divWithoutCounter model

divWithoutCounter : Model -> Html Msg
divWithoutCounter model =
  div []
      [ div [ buttonStyle "black", onClick Click ]
            [ text model.button_text ]]

divWithCounter : Model -> Int -> Int -> Html Msg
divWithCounter model counter_value max_work_time =
  div []
      [ div [ buttonStyle "grey" ]
            [ text model.button_text
            , div [ coolDownStyle ((toFloat counter_value) / (toFloat max_work_time) * 100) ] []]
      ]
