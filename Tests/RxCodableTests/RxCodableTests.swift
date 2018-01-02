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
      "id":123,
      "name":"iamchiwon",
    ]
    let user = User(id: 123, name: "iamchiwon")
    XCTAssertEqual(try Observable.just(dictionary).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Single.just(dictionary).map(User.self).toBlocking().first()!, user)
    XCTAssertEqual(try Maybe.just(dictionary).map(User.self).toBlocking().first()!, user)
  }
}
