{-# LANGUAGE LambdaCase, TemplateHaskell #-}
import Graphics.Gloss.Interface.Pure.Game
import Linear
import Data.Bifunctor (first)

tau = 2 * pi

windowSize = 620
radius = 300
maxSpeed = 0.05
pointSize = 15
pointDistance = 1/10

data World = World (M33 Float) [(V3 Float, Color)]

rotation :: Float -> Float -> M33 Float
rotation speed angle = t3 !*! t2 !*! t1
  where
    (a, b) = (cos angle, sin angle)
    (c, d) = (cos speed, sin speed)

    t1 = V3
      (V3 a b 0)
      (V3 (-b) a 0)
      (V3 0 0 1)

    t2 = V3
      (V3 c 0 d)
      (V3 0 1 0)
      (V3 (-d) 0 c)

    t3 = V3
      (V3 a (-b) 0)
      (V3 b a 0)
      (V3 0 0 1)

main :: IO ()
main = play
  (InWindow "Projective Plane" (windowSize, windowSize) (50, 50))
  white  --background color
  30     --frame rate
  (World identity startPoints)
  draw
  input
  (const update)

startPoints :: [(V3 Float, Color)]
startPoints =
  [ (point 0, red)
  , (point (tau / 3), green)
  , (point (tau * 2 / 3), blue)
  ]
  where
    point angle = normalize
      (V3 (cos angle * pointDistance) (sin angle * pointDistance) 1)

draw :: World -> Picture
draw (World _ points) =
  Pictures (Circle radius : map drawPoint points)
  where
    drawPoint (V3 x y z, color) =
      let (x', y') = if z > 0 then (x, y) else (-x, -y) in
      (Color color . translate (x' * radius) (y' * radius))
      (ThickCircle 0 pointSize)

input :: Event -> World -> World
input event (World mat points) = World mat' points
  where
    mat' = case event of
      EventMotion (x, y) -> let
        mouse = V2 x y
        speed = maxSpeed * min 1 (norm mouse / radius)
        angle = unangle mouse
        in if isNaN angle
          then identity
          else rotation speed angle
      _ -> mat

update :: World -> World
update (World mat points) = World mat points'
  where points' = (map . first) (mat !*) points
