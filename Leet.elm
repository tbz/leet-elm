import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (Time, second)
import Date exposing (Date, fromTime)
import String exposing (concat)

isDateLeet : Date -> Bool
isDateLeet date =
  let
    hour = Date.hour date
    minute = Date.minute date
    isHour = (hour == 13)
    isMinute = (minute == 37)
  in
    (isHour && isMinute)

minutesLeft : Date -> Int
minutesLeft date =
  let
    hour = Date.hour date
    minute = Date.minute date
    hoursDiff = 13 - hour
    hoursLeft = 
      if hoursDiff > 0
      then hoursDiff
      else 24 + hoursDiff
    minutesDiff = 37 - minute
    minutesLeft =
      if minutesDiff > 0
      then minutesDiff
      else 37 + minutesDiff
    totalMinutesLeft = minutesLeft + hoursLeft * 60
  in 
    totalMinutesLeft

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model = Time

init : (Model, Cmd Msg)
init =
  (0, Cmd.none)


-- UPDATE

type Msg
  = Tick Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      (newTime, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick


-- VIEW

view : Model -> Html Msg
view model =
  let
    date = fromTime model
    isLeet = isDateLeet date
    left = minutesLeft date
    out =
      concat [toString isLeet," ",toString left]

  in
    div[] [
      h1 [] [ text "Is it 1337?" ],
      p [ attribute "class" (if isLeet then "yes" else "no") ] [ text (if isLeet then "Yes!" else "No") ],
      p [] [ text ("Next is in " ++ (toString left) ++ " minute(s)") ]
    ]





