module Euler where

import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Cairo (toFile)

{-
HOW TO USE:
dt = size of step. Increase this to reduce error term
tmin and tmax is the range you want to conduct Euler method over
y_0 is initial y value
Write your f(y) func in f and rebuild and exec to get graph in `./euler.png`
-}

dt = 0.1 :: Float
tmin = 0.0 :: Float
tmax = 10.0 :: Float
y_0 = 1.0 :: Float
f t = -t

ts = [tmin,tmin+dt..tmax] -- small error due to using ranges with floats
ys = take (length ts) $ iterate (\y_i -> y_i + f y_i * dt) y_0

main = toFile def "euler.png" $ do
  layout_title .= "Euler Method"
  let actYs = [exp(-t) | t <- ts]
  plot (line "Euler Projection" [[(x,y) | (x,y) <- zip ts ys]])
  plot (line "Actual Function" [[(x,y) | (x,y) <- zip ts actYs]])
  plot (line "Ratio" [[(x,y) | (x,y) <- zip ts $ zipWith (/) ys actYs]])
