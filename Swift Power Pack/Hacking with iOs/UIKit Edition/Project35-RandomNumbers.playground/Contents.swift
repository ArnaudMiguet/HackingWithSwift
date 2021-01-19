import UIKit
import GameplayKit

print(GKRandomSource.sharedRandom().nextInt())
print(GKRandomSource.sharedRandom().nextInt(upperBound: 6))

// Mid performance algorithm :
let arc4 = GKARC4RandomSource()
arc4.nextInt(upperBound: 20)

// Low perf, high randomness :
let mersenne = GKMersenneTwisterRandomSource()
mersenne.nextInt(upperBound: 20)

let d6 = GKRandomDistribution.d6()
d6.nextInt()


// Shuffled distribution : avoids frequent repeats "Fair distribution"
let shuffled = GKShuffledDistribution.d6()
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
