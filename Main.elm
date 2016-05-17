import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Html.App as App
import Game exposing (init, view, update, Msg, subscriptions)

main =
  App.program { init = init 0 200
              , view = view
              , update = update
              , subscriptions = subscriptions }
