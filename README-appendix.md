# Appendix:  Computers and Randomness

In the interest of including as many readers as possible, a brief description:

Computers are designed to perform repeatable tasks deterministically.  As such,
they're not very good at generating truly random data.


## Pseudo-randomness

However, computers **can** be good at generating data that **appears** random
to a human.  They do this by using a mathematical function that takes a "seed"
value, and then uses that seed to generate sequences that are difficult for a
human to predict.

Here's an [obligatory Wikipedia
link](https://en.wikipedia.org/wiki/Pseudorandom_number_generator).

The important thing to know about this process is that, **given a particular
seed, a PRNG will always produce the same sequence of numbers**.  The usual
workaround to make this data appear more random is to seed the PRNG with an
external value, such as "the number of milliseconds on the current timestamp
from the clock".


## [Pseudo]Randomness and Test Flakiness

As mentioned in the README, Faker does allow its PRNG to be seeded (see
[Deterministic
Random](https://github.com/faker-ruby/faker#deterministic-random) in the Faker
README).  This feature makes it possible to reproduce a failing test run.

However, even when using a known seed, it's possible to have a test that only
fails when it's given specific data.

To name a trivial example:  if Faker is used to generate names, and the system
being tested has a validation rule that names must be at least four characters
long, then a PRNG seed that produces the sequence [ "Bjork Goodmundsdottir",
"Michelle Yeoh", "Bruce Lee", "T'Challa", "Neo" ] will cause a test failure
when it gets the name "Neo."

In a test of the name validation itself, you'll probably have specific
hardcoded values.  However, in a complex system (which is to say, any system
worth testing), that validation rule on names can cause completely unrelated
tests to fail for reasons that have nothing to do with the behavior described
in that test.

To continue the example, if that validation were part of a system that keeps
track of books and authors, a test that makes sure the `Book` class can have a
list of `Author` instances might fail because it happened to be given an
`Author` with a name that didn't conform to the validation rule.

This still doesn't seem so bad -- until we add time as a factor.  In my
experience, it is not unusual for Rails apps to have test suites with run times
measured im minutes.  If a test fails even a significant fraction of the time,
most developers I've worked with will shrug, click "rerun" in their CI server,
and then... go complain about it in Slack.

Occasionally, a developer with more experience and/or passion for correctness
might attempt to reproduce the failure locally so they can identify and remove
it.  Unfortunately, if the test suite is slow enough that it takes three
minutes and several hundred ActiveRecord tests to get to the failure,
identifying the problem can be an extremely daunting prospect.


## Bonus Reading

As a reward for reading my pedantry, please enjoy [this article about using
webcams and Lava Lamps to generate random
data](https://blog.cloudflare.com/randomness-101-lavarand-in-production/).

