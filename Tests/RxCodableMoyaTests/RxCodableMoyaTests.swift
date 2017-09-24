import XCTest
import Moya
import RxBlocking
import RxCodable
import RxSwift
import TestUtil

class RxCodableMoyaTests: XCTestCase {
  func testMapCodableFromMoyaResponse() {
    let jsonString = """
    {
      "id": 123,
      "name": "devxoul"
    }
    """
    let jsonData = jsonString.data(using: .utf8) ?? Data()
    let response = Moya.Response(statusCode: 200, data: jsonData)
    let user = User(id: 123, name: "devxoul")
////    XCTAssertEqual(try Observable.just(response).map(User.self).toBlocking().first()!, user)
////    XCTAssertEqual(try Single.just(response).map(User.self).toBlocking().first()!, user)
////    XCTAssertEqual(try Maybe.just(response).map(User.self).toBlocking().first()!, user)
  }
}
