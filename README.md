# Login APP

Login APP is a Flutter application to demonstrate the flow of a login usecase.

#### Brief note before begging

The the app and this read me are in there first versions, there are much more improvements and features to be added to the app, and good articles I will work on very soon to describe the way that the Clean Architecture has been implemented in this app.

## App Components


In our project we will be implementing the clean architecture and TDD (Test Driven Development). That has been introduced by [Uncle Bob (Robert C. Martin)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)


How can such an independence be achieved? on the layered "onion" image below, the horizontal arrows ---> represent dependency flow. For example, Entities do not depend on anything, Use Cases depend only on Entities etc.

![](https://i.ibb.co/ZLsrwqk/clean.jpg)

## Clean Architecture & Flutter

Understanding Uncle Bob's S.O.L.I.D principles and Clean Architecture in general is not that hard, but implementing them in your code that is the huge milestone we all faced.

So this repository is to lead you to make those theoretical principles to be actually implemented in your coming up projects, we will be implementing a login use case

#### Shoutout to [Reso Coder](http://resocoder.com/) for the descriptive diagrams and the idea in whole

![](https://i.ibb.co/WDFmxXB/app-diagram.png)


## Explanation & Project Organization
Every "feature" of the app, will be divided into 3 layers - presentation, domain and data, these layers are equivalent to native Android's modules if you have been using Clean Architecture with native Android whereas you were using Java or Kotlin. The app we're building will have only one feature which is logging in a user to our system.

![](https://i.ibb.co/d5VLMbS/Screen-Shot-2019-12-10-at-4-47-25-PM.png)


### Presentation
We obviously need widgets to display something on the screen. These widgets then dispatch events to the Bloc and listen for states.

![](https://i.ibb.co/QmSn1hr/presentation.png)

We will have only a single page with widgets called LoginPage with a single LoginBloc.

![](https://i.ibb.co/KwRR76Y/Screen-Shot-2019-12-10-at-4-49-58-PM.png)


### Domain
Domain is the inner layer which shouldn't be susceptible to the whims of changing data sources or porting our app to Angular Dart, or even deciding to go with react native in future versions, as it will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.

How is the domain layer completely independent when it gets data from a Repository, which is from the data layer?  Do you see that fancy colorful gradient for the Repository? That signifies that it belongs to both layers at the same time. We can accomplish this with dependency inversion.


#### Again a huge shoutout to [Reso Coder](http://resocoder.com/) for this amazing diagram which shows how the repository is both considered in the domain and in the data layer as well.

![](https://i.ibb.co/30Byk2V/domain-layer-diagram.png)

That's just a fancy way of saying that we create an abstract Repository class (Interface/Delegate) defining a contract of what the Repository must do - this goes into the domain layer. We then depend on the Repository "contract" defined in domain, knowing that the actual implementation of the Repository in the data layer will fulfill this contract.


There won't be much business logic to execute in the app, since we're just getting the email and password from the user and logging him in to the system. As for the business objects, there will be a single, fairly lean Entity called  User - just the users' data.

![](https://i.ibb.co/NrHJprY/Screen-Shot-2019-12-10-at-4-54-17-PM.png)


### Data
The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is usually for getting remote (API) data and the other for caching that data. Repository is where you decide if you return fresh or cached data, when to cache it and so on.

You may notice that data sources don't return Entities but rather Models. The reason behind this is that transforming raw data (e.g JSON) into Dart objects requires some JSON conversion code. We don't want this JSON-specific code inside the domain Entities.

![](https://i.ibb.co/z6T3bBP/data-layer-diagram.png)

Therefore, we create Model classes which are responsible of interacting with the outside world.

The RemoteDataSource will perform HTTP POST requests on the our API. LocalDataSource will simply cache user's data using the shared_preferences package.

These two data sources will be "combined" in LoginRepository which will be the single source of truth for the interesting login app data.

![](https://i.ibb.co/L5SbkyV/Screen-Shot-2019-12-10-at-4-58-43-PM.png)

### Testing

After going through headache we caused to ourselves by abstracting our application into different layers we have to complete this achievement by testing each part on its own, that is what is called [Unit Testing](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

In each one of our usecases there are multiple test cases for it, so we can test whether the user has entered a wrong password, the email does not even exist...etc.

#### Packaging

The testing package follows our production code packaging

![](https://i.ibb.co/R3Ng1Lq/Screen-Shot-2019-12-10-at-9-59-25-PM.png)


This would give us a permanent evidence that the functionality we tested works as expected.




## Installation


When logging in the application will communicate with an API, you can test the app by entering the email :
`taha@test.com` and the password : `12345678`

