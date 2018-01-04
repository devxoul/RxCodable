import XCTest
import RxBlocking
import RxCodable
import RxSwift
import TestUtil

class RxCodableTests: XCTestCase {
  func testMapCodableFromJSONData() {
    let jsonString = """
    {
      "id": 123,
      "name": "devxoul"
    }
    """
    let jsonData = jsonString.data(using: .utf8) ?? Data()
    let user = User(id: 123, name: "devxoul")
    XCTAssertEqual(try Observable.just(jsonData).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Single.just(jsonData).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Maybe.just(jsonData).map(User.self).toBlocking().first()!, user)
  }

  func testMapCodableArrayFromJSONData() {
    let jsonString = """
    [
      {
        "id": 123,
        "name": "devxoul"
      },
      {
        "id": 456,
        "name": "hello"
      }
    ]
    """
    let jsonData = jsonString.data(using: .utf8) ?? Data()
    let users = [
      User(id: 123, name: "devxoul"),
      User(id: 456, name: "hello"),
    ]
    XCTAssertEqual(try Observable.just(jsonData).map([User].self).toBlocking().first()!, users)
    XCTAssertEqual(try Single.just(jsonData).map([User].self).toBlocking().first()!, users)
    XCTAssertEqual(try Maybe.just(jsonData).map([User].self).toBlocking().first()!, users)
  }

  func testMapCodableFromJSONString() {
    let jsonString = """
    {
      "id": 123,
      "name": "devxoul"
    }
    """
    let user = User(id: 123, name: "devxoul")
    XCTAssertEqual(try Observable.just(jsonString).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Single.just(jsonString).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Maybe.just(jsonString).map(User.self).toBlocking().first()!, user)
  }

  func testMapCodableArrayFromJSONString() {
    let jsonString = """
    [
      {
        "id": 123,
        "name": "devxoul"
      },
      {
        "id": 456,
        "name": "hello"
      }
    ]
    """
    let users = [
      User(id: 123, name: "devxoul"),
      User(id: 456, name: "hello"),
    ]
    XCTAssertEqual(try Observable.just(jsonString).map([User].self).toBlocking().first()!, users)
    XCTAssertEqual(try Single.just(jsonString).map([User].self).toBlocking().first()!, users)
    XCTAssertEqual(try Maybe.just(jsonString).map([User].self).toBlocking().first()!, users)
  }
  
  func testMapCodableFromDictionary() {
    let dictionary: [String:Any] = [
      "id": 123,
      "name": "iamchiwon",
    ]
    let user = User(id: 123, name: "iamchiwon")
    XCTAssertEqual(try Observable.just(dictionary).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Single.just(dictionary).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Maybe.just(dictionary).map(User.self).toBlocking().first()!, user)
  }
  
  func testMapCodablemapDictionary() {
    let dictionary: [String:Any] = [
      "id": 123,
      "name": "iamchiwon",
    ]
    let user = User(id: 123, name: "iamchiwon")
    XCTAssertEqual(try Observable.just(user).mapDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Single.just(user).mapDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Maybe.just(user).mapDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
  }
  
  func testMapCodablemapJSONString() {
    let jsonString = """
    {
      "id": 123,
      "name": "iamchiwon"
    }
    """
    let user = User(id: 123, name: "iamchiwon")
    XCTAssertEqual(try Observable.just(user).mapJSONString().toBlocking().first()!,
                   try Observable.just(jsonString).map(User.self).mapJSONString().toBlocking().first()!)
    XCTAssertEqual(try Single.just(user).mapJSONString().toBlocking().first()!,
                   try Single.just(jsonString).map(User.self).mapJSONString().toBlocking().first()!)
    XCTAssertEqual(try Maybe.just(user).mapJSONString().toBlocking().first()!,
                   try Maybe.just(jsonString).map(User.self).mapJSONString().toBlocking().first()!)
  }
  
  func testMapCodableArraymapJSONString() {
    let jsonString = """
    [
      {
        "id": 123,
        "name": "iamchiwon"
      },
      {
        "id": 456,
        "name": "devxoul"
      }
    ]
    """
    let users = [
      User(id: 123, name: "iamchiwon"),
      User(id: 456, name: "devxoul"),
    ]
    XCTAssertEqual(try Observable.just(users).mapJSONString().toBlocking().first()!,
                   try Observable.just(jsonString).map([User].self).mapJSONString().toBlocking().first()!)
    XCTAssertEqual(try Single.just(users).mapJSONString().toBlocking().first()!,
                   try Single.just(jsonString).map([User].self).mapJSONString().toBlocking().first()!)
    XCTAssertEqual(try Maybe.just(users).mapJSONString().toBlocking().first()!,
                   try Maybe.just(jsonString).map([User].self).mapJSONString().toBlocking().first()!)
  }
  
  func testMapCodableFromJSONStringmapDictionary() {
    let jsonString = """
    {
      "id": 123,
      "name": "iamchiwon"
    }
    """
    let dictionary: [String:Any] = [
      "id": 123,
      "name": "iamchiwon",
    ]
    XCTAssertEqual(try Observable.just(jsonString).map(User.self).mapDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Single.just(jsonString).map(User.self).mapDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Maybe.just(jsonString).map(User.self).mapDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
  }
  
  func testMapCodableArraymapDictionary() {
    let dictionaries: [[String:Any]] = [
      [
      "id": 123,
      "name": "iamchiwon",
      ],
      [
      "id": 456,
      "name": "devxoul",
      ]
    ]
    let users = [
      User(id: 123, name: "iamchiwon"),
      User(id: 456, name: "devxoul"),
    ]
    XCTAssertEqual(try Observable.just(dictionaries).map([User].self).mapJSONString().toBlocking().first()!,
                   try Observable.just(users).mapJSONString().toBlocking().first()!)
    XCTAssertEqual(try Single.just(dictionaries).map([User].self).mapJSONString().toBlocking().first()!,
                   try Single.just(users).mapJSONString().toBlocking().first()!)
    XCTAssertEqual(try Maybe.just(dictionaries).map([User].self).mapJSONString().toBlocking().first()!,
                   try Maybe.just(users).mapJSONString().toBlocking().first()!)
  }
}
