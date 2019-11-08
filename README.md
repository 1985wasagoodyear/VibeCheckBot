#  Changes

* Application now determines which screen to show
    * 1. Login Screen
    * 2. Make Tweet/Check Vibes Screen

* Decision is done by checking what is in my Keychain
    * Oauth tokens

## AppDelegate

* Owns the TwitterService instance
    * checks the token
    * shares the instance with any VC that uses it
    * no Singleton.
    
## Keychain

* Apple's first-party encrypted store
* Good for:
        * saving small (private) data
        * passwords, token, usernames, emails
        * address (sometimes?)
* Do not use this for BLOBs
* Retains data past Application deletion

## App Deletion

* anything made in app is destroyed
    * SQL stores
    * Core Data
    * Files via FileManager
    * UserDefaults
* Keychain is separate of app
    * lives past deletion
    
## Workaround:

* save key data in Keychain
* save a flag in the UserDefaults
* if flag exists
        * user is current user
* if the flag does not exist:
        * user may not be the current user
        * delete the data
        * send to login/some other data-entry screen
                * once some data is set here
                * set the flag.













