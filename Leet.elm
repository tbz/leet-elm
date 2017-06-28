module Main exposing (..)

import Date exposing (Date, fromTime)
import Html exposing (..)
import Html.Attributes exposing (..)
import String exposing (concat)
import Time exposing (Time, second)


isDateLeet : Date -> Bool
isDateLeet date =
    let
        hour =
            Date.hour date

        minute =
            Date.minute date

        isHour =
            hour == 13

        isMinute =
            minute == 37
    in
    isHour && isMinute


minutesLeft : Date -> Int
minutesLeft date =
    let
        hour =
            Date.hour date

        minute =
            Date.minute date

        diff =
            (13 - hour) * 60 + (37 - minute)
    in
    if diff < 0 then
        diff + 1440
    else
        diff


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        date =
            fromTime model

        isLeet =
            isDateLeet date

        left =
            minutesLeft date

        out =
            concat [ toString isLeet, " ", toString left ]
    in
    div []
        [ h1 [] [ text "Is it 1337?" ]
        , p
            [ attribute "class"
                (if isLeet then
                    "yes"
                 else
                    "no"
                )
            ]
            [ text
                (if isLeet then
                    "Yes!"
                 else
                    "No"
                )
            ]
        , p [] [ text ("Next is in " ++ toString left ++ " minute(s)") ]
        ]
