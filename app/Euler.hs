module Euler where

import Graphics.Rendering.Chart
import Graphics.Rendering.Chart.Backend.Cairo
import Data.Colour(opaque)
import Data.Colour.Names
import Control.Lens
import Data.Default.Class

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
lineWidth = 2 :: Double

ts = [tmin,tmin+dt..tmax] -- small error due to using ranges with floats
ys f = take (length ts) $ iterate (\y_i -> y_i + f y_i * dt) y_0

main = renderableToFile def "euler.png" $ toRenderable layout
  where
    -- euler method line
    eulerproj = plot_lines_style . line_color .~ opaque blue
      $ plot_lines_style . line_width .~ lineWidth
      $ plot_lines_values .~ [[(x,y) | (x,y) <- zip ts $ ys f]]
      $ def

    -- actual func line
    actual = plot_lines_style . line_color .~ opaque red
      $ plot_lines_style . line_width .~ lineWidth
      $ plot_lines_values .~ [[(x,y) | (x,y) <- zip ts $ map (\t -> exp(-t)) ts]]
      $ def

    -- ratio of euler to actual line
    ratio = plot_lines_style . line_color .~ opaque purple
      $ plot_lines_style . line_width .~ lineWidth
      $ plot_lines_values .~ [[(x,y) | (x,y) <- zip ts $ zipWith (/) (ys f) $ map (\t -> exp(-t)) ts]]
      $ def

    -- general graph settings
    layout = layout_title .~ "Euler Method"
      $ layout_x_axis . laxis_override .~ axisGridHide
      $ layout_plots .~ [toPlot actual, toPlot eulerproj, toPlot ratio]
      $ layout_grid_last .~ False
      $ def