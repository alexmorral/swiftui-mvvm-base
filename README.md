# SwiftUI MVVM Base

This project aims to be a base for MVVM projects made with SwiftUI. It downloads some data from [SWAPI](https://swapi.dev) API, stores it into CoreData and presents it nicely in a SwiftUI list.

***

## Architecture

The whole application is designed in a protocol oriented approeach so each element can be exchanged without having to change the implementation of the other parts.

### **Endpoints**

Endpoints folder are meant to have the information about API endpoints. They must conform to `APIRequest` so when the network request is made by `APIClient`, it can build the proper `URLRequest`.

### **Repositories**

Repositories are the point of communication between the ViewModels and the Remote or Local data. Repositories have two dataSources from which they get their data.

#### **LocalDataSource**

The LocalDataSource is where the logic to get the local data goes. In this example we are communicating with CoreData, but one could exchange it to use another database very easily.

#### **RemoteDataSource**

RemoteDataSource is in charge of communicating with the API. The current implementation uses an instance of `APIClient` but it could be exchanged for anything else.

## Navigation

Right now, the navigation is implemented using the [NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack) as a core element and using `navigationDestination` to check for any changes in the Route array.

### Implamentation

Currently there is a `Route` enum that contains each possible route within the navigation.

Each ViewModel contains a Binding to the array of routes that the NavigationStack uses, so it can append and remove routes to navigate through the app.

### Warnings

Currently the project throws the following runtime error.
```
Publishing changes from within view updates is not allowed, this will cause undefined behavior.
```
It seems to be a SwiftUI bug that I hope they fix in the next versions.


