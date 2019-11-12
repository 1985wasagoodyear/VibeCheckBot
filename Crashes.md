#  Crashes

1. Generate a crash log
2. These can be gathered from any iPhone
3. Contain a stack trace of the current thread, execution, etc at the time of the crash.

# Problem

Can't always get a crash log easily from a customer on the other side of the state/country/planet.

# Solution

Use some tool to automatically collect crash logs, like Crashlytics.

# Technical Concerns:

1. Collected crash logs don't have the name of the function, only its memory address
2. Memory addresses for a function differ between App versions.

# Technical Solution

1. Need to generate a symbols file
2. Use symbols file with the crash log to "symbollicate" them.
3. Can now read it like the stack trace on Xcode's debugger.

Remark: Crashlytics can automatically symbollicate logs and take a new symbols file on each build, as set up here.
