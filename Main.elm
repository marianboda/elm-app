import Html
import Mouse
import String

view: Int -> Html.Html
view x = Html.text (toString x)

double x = x * 2

doubleSignal = Signal.map double Mouse.x

main: Signal.Signal Html.Html
main = Signal.map view doubleSignal
