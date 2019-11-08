#  Dependency Injection (DI)

* a technique.

### Scenario:
* Objects need a concrete instance to work with something
    * eg: App needs Twitter
* Mechanisms into the app should not depend on Twitter.
    * tables for data
    * I may not be able to load that data, but the tables should still work.

### Definition:
* The act of giving an object its dependency.
* The object is built or given a dependency
    * it does not make this object itself.


## Methodology (in iOS):

* build things around Protocols
* have your concrete dependencies adopt the Protocols
* anyone that uses the dependencies works with the Protocols, instead.

* if the object does not make instances of the dependencies, who does?
        * some parent object creates it
            * eg. AppDelegate
        * Factory class
            * dedicated class to make objects

# SOLID Principles

(P = Principle)

* Single Responsibility P.
* Open/Close P.
* Liskov's Substitution P.
* Interface Segregation P.
* Dependency Inversion P.
        * this is where Dependency Injection lives
        * Deoendency Injection is an application of Dependency Inversion

