# SOLID Principles

(P = Principle)

* Single Responsibility P. (SRP)
`A class should have one, and only one, reason to change.`
    * each object does one thing, and one thing only
    

* Open/Close P. (OCP)
`You should be able to extend a classes behavior, without modifying it.`
    * adding functionality should be fine in extensions
    * i should not need to change the source code to add functionality
    * i don't need to subclass to add functionality
    

* Liskov's Substitution P.
`Derived classes must be substitutable for their base classes.`
    * eg. custom UIImageView subclass should still be usable as a UIImageView
    * i don't know how to break this


* Interface Segregation P.
`Make fine grained interfaces that are client specific.`
    * don't force users/clients to implement all interfaces
    * eg. delegate to an object
        * delegate could have dozens of functions
                * and they are all mandatory
        * problem exists when the client only wants to use some functions
        * solution: make different sets of delegates that can be used
                * UITableView: has 2 delegates: 
                        `UITableViewDelegate`, 
                        `UITableViewDataSource`


* Dependency Inversion P. (DI)
`Depend on abstractions, not on concretions.`
    * OBJECTS and what they depend on
    * ViewController uses something that works with a TwitterProtocol
        * don't need the actual Twitter to function.
    * this is a principle
        * Dependency Injection is an application.
        * in iOS, usually do so with Protocols defining our abstract interfaces.
