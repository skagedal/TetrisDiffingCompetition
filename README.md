# The Tetris Diffing Competition

This is a comparison of diffing frameworks for UIKit table views and collection views.  I wrote a blog post called [Collection View Tetris][cwt], where I presented a fun hack: Tetris implemented using a quite ordinary Collection View and its default animation.  This requires that all possible animations are implemented – inserts, deletes and moves of items and sections, including moving items from one section to another. 

## The (slightly ad hoc) rules

There is a whole bunch of diffing frameworks available for iOS, but to be eligble for the Tetris Diffing Competition, they have to meet the following criteria:

* There has to be a diffing API that handles both items and sections. 
* There has to also be a method for running the whole animation – as you can read about in my blog post, supporting all of this is non-trivial and requires more than the diffing itself. 
* I have to understand how to use it all in reasonable time.

## The results

|Framework           |Version |Result|Comment                                      |
|:-------------------|:------:|:----:|:--------------------------------------------|
|[DifferenceKit][dk] |0.6.0   |  🎉  |Works just as intended.                      |
|[Dwifft][dwifft]    |0.9     |  😐  |Works, but does not seem to animate moves.   |
|[Differ][differ]    |1.3.0   |  😞  |Does not work.                               |

The clear winner here is DifferenceKit, which was the only library that truly passed the test. Whether or not you want to take this as an indicator of general quality of the framework, I'm not sure – but I happen to think that this library does seem like a good choice for your general purpose diffing needs. It has a flexible and powerful API, uses a performant algorithm and is well documented. 

There are some things I think could be improved.  Notably, it does not allow you to pass on a completion handler to the `performBatchUpdates` methods. This seem to be something it has in common with many other of these frameworks. 

Oh, I should mention that there is one more diffing framework that is up to the task – my own [SKRBatchUpdates](https://github.com/skagedal/SKRBatchUpdates), which is what led me to do this Tetris thing.  It is, however, not packaged for general consumtion as a framework – any of these other links here will quite probably better fulfill your diffing needs. 

## Other diffing frameworks

Here's another nice thing about [DifferenceKit][dk]: its README has a nice comparison of available diffing frameworks. So I will refer you to that. It may very well be another one that best matches your needs. 

## Prove me wrong with a Pull Request!

This repository contains an app where you can test Collection View Tetris with each of the tested frameworks.  If you find that I'm being unfair towards some framework, using it wrong, or if there's just something missing – please file a pull request.  The competition is always up for re-evaluation. 


[cwt]: https://skagedal.github.io/2018/08/23/collection-view-tetris.html
[dk]: https://github.com/ra1028/DifferenceKit
[dwifft]: https://github.com/jflinter/Dwifft
[differ]: https://github.com/tonyarnold/Differ