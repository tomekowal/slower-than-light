import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import StartApp
import Time exposing (..)
import Signal exposing (Signal, map)
import Effects exposing (Effects)
import Game exposing (init, view, update, Action)

ticks : Signal Action
ticks =
  Signal.map (\(timeStamp, tick) -> Game.Tick) (timestamp (every (second/10)))

app =
  StartApp.start { init = init 0 20
                 , view = view
                 , update = update
                 , inputs = [ticks] }

main =
  app.html
