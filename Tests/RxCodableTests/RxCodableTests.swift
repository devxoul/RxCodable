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
    let dictionary:[String:Any] = [
      "id": 123,
      "name": "iamchiwon",
    ]
    let user = User(id: 123, name: "iamchiwon")
    XCTAssertEqual(try Observable.just(dictionary).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Single.just(dictionary).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Maybe.just(dictionary).map(User.self).toBlocking().first()!, user)
  }
  
  func testMapCodableToDictionary() {
    let dictionary:[String:Any] = [
      "id": 123,
      "name": "iamchiwon",
      ]
    let user = User(id: 123, name: "iamchiwon")
    XCTAssertEqual(try Observable.just(user).toDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Single.just(user).toDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Maybe.just(user).toDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
  }
  
  func testMapCodableToJSONString() {
    let jsonString = """
    {
      "id": 123,
      "name": "iamchiwon"
    }
    """
    let user = User(id: 123, name: "iamchiwon")
    XCTAssertEqual(try Observable.just(user).toJSONString().toBlocking().first()!,
                   try Observable.just(jsonString).map(User.self).toJSONString().toBlocking().first()!)
    XCTAssertEqual(try Single.just(user).toJSONString().toBlocking().first()!,
                   try Single.just(jsonString).map(User.self).toJSONString().toBlocking().first()!)
    XCTAssertEqual(try Maybe.just(user).toJSONString().toBlocking().first()!,
                   try Maybe.just(jsonString).map(User.self).toJSONString().toBlocking().first()!)
  }
  
  func testMapCodableFromJSONStringToDictionary() {
    let jsonString = """
    {
      "id": 123,
      "name": "iamchiwon"
    }
    """
    let dictionary:[String:Any] = [
      "id": 123,
      "name": "iamchiwon",
      ]
    XCTAssertEqual(try Observable.just(jsonString).map(User.self).toDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Single.just(jsonString).map(User.self).toDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
    XCTAssertEqual(try Maybe.just(jsonString).map(User.self).toDictionary().toBlocking().first()! as NSObject, dictionary as NSObject)
  }
}
