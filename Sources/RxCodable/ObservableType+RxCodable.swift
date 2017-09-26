import Foundation
import RxSwift

public extension ObservableType where E == Data {
  public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> Observable<T> where T: Decodable {
    return self.map { data -> T in
      let decoder = decoder ?? JSONDecoder()
      return try decoder.decode(type, from: data)
    }
  }
}

public extension ObservableType where E == String {
  public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> Observable<T> where T: Decodable {
    return self
      .map { string in string.data(using: .utf8) ?? Data() }
      .map(type, using: decoder)
  }
}
