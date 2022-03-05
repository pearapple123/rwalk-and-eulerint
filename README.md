# rwalk-and-eulerint

My implementation of Random Walk and Euler Integration in Haskell

## Implementation of Rwalk
Quite proud of this.
- Use MonadRandom's `getRandomRs (-1,1)` and some filtering to get a list of -1s and 1s
- Take from this list num of elems = `nstep`
- In `main`, `replicateM` this num of times equal to `walks`
- After some Haskell-chart stuff, `mapM_` a template plot function for each walk in `allRwalks`

## Main.hs
Completely useless, but it seems `stack build` throws a fit if it isn't there.
