# RxCodable

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/RxCodable.svg)](https://cocoapods.org/pods/RxCodable)
[![Build Status](https://travis-ci.org/devxoul/RxCodable.svg?branch=master)](https://travis-ci.org/devxoul/RxCodable)
[![codecov](https://img.shields.io/codecov/c/github/devxoul/RxCodable.svg)](https://codecov.io/gh/devxoul/RxCodable)

RxSwift wrapper for Codable.

## At a Glance

```swift
struct User: Codable {
  var name: String
}

// Data -> User
Observable<Data>.just(jsonData).map(User.self)
Single<Data>.just(jsonData).map(User.self)
Maybe<Data>.just(jsonData).map(User.self)

// String -> User
Observable<String>.just(jsonString).map(User.self)
Single<String>.just(jsonString).map(User.self)
Maybe<String>.just(jsonString).map(User.self)
```

## Installation

* **Using [CocoaPods](https://cocoapods.org)**:

    ```ruby
    pod 'RxCodable'
    ```

## Contributing

Any discussions and pull requests are welcomed 💖

To create a Xcode project:

```console
$ swift package generate-xcodeproj
```

## License

RxCodable is under MIT license. See the [LICENSE](LICENSE) for more info.
