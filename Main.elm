import Html
import Mouse
import String

view : Int -> Html.Html
view count = Html.text (toString count)

countSignal : Signal Int
countSignal = Signal.foldp (\_ total-> total + 1) 0 Mouse.clicks

main : Signal.Signal Html.Html
main = Signal.map view countSignal
