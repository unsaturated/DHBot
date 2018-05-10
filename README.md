# DH Bot
## Overview
DH Bot was an iOS app first released on November 11, 2014. It was built to control the DreamHost API. The final release of the app was March 16, 2015. 

The DreamHost APIs have since been deprecated and removed from the DreamHost web control panel. Without an API to access the app itself became useless. Further, I decided to cancel my Apple Developer membership, thereby ending its tenure on the App Store on April 28, 2016.

Read about the app's history and check out screen shots [on my website](https://matt.unsaturated.com/dhbot).

## Code
In the `Classes` directory you'll see the following:

 - `API` - commands and data models for the DreamHost web API
 - `Extensions` - dependencies not added with Pods
 - `Models` - persistence models for storing data locally
 - `Views` - presentation of data from the API

In terms of code line count the app is what you'd expect for a fully native application. 

| Language     | Files | Blank | Comment | Code |
|--------------|------:|------:|--------:|-----:|
| Objective C  |   136 |  2455 |    2245 | 7430 |
| C/C++ Header |   138 |   785 |    2501 | 1044 |
| Sum          |   274 |  3240 |    4746 | 8474 |

## Coda
As a longtime DreamHost customer I was writing the app for myself first but hoped others would discover its value. I also found the risk in developing a product based upon a service I didn't control. There's no guarantee the terms of that service will remain compatible with your business, or that the service itself won't be shut down. 

Plan your apps accordingly.