module RandWalk where

import Control.Monad.Random.Class
import Control.Monad (replicateM)
import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Cairo (toFile)

walks :: Int
walks = 10

nstep :: Int
nstep = 10000

rwalkM :: MonadRandom m => m [Int]
rwalkM = do
  rands <- (getRandomRs (-1,1) :: MonadRandom m => m [Int] )
  let walk = take nstep $ filter (/=0) rands
  return $ scanl (\x acc -> x + acc) 0 walk

main :: IO ()
main = do
  allRwalks <- replicateM 10 rwalkM
  toFile def "rwalk.png" $ do
    layout_title .= "Random Walk"
    mapM_ (\xs -> plot (line "" [ [(x,y) | (x,y) <- zip [1..nstep] xs] ])) allRwalks
