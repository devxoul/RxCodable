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

public extension ObservableType where E == [String: Any] {
  public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> Observable<T> where T: Decodable {
    return self
      .map { dict in try JSONSerialization.data(withJSONObject: dict) }
      .map(type, using: decoder)
  }
}

public extension ObservableType where E == [[String: Any]] {
  public func map<T>(_ type: Array<T>.Type, using decoder: JSONDecoder? = nil) -> Observable<[T]> where T: Decodable {
    return self
      .flatMap { Observable.from($0) }
      .map(T.self, using: decoder)
      .toArray()
  }
}

public extension ObservableType where E: Encodable {
  public func mapDictionary(_ encoder: JSONEncoder? = nil) -> Observable<[String: Any]> {
    return self.map { encodable -> [String: Any] in
      let data = try (encoder ?? JSONEncoder()).encode(encodable)
      let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
      guard let dictionary = dict else {
        throw RxCodableError.castingFailed(data: data, type: [String: Any].self)
      }
      return dictionary
    }
  }
}

public extension ObservableType where E: Encodable {
  public func mapJSONString(_ encoder: JSONEncoder? = nil, encoding: String.Encoding = .utf8) -> Observable<String> {
    return self.map { encodable -> String in
      let data = try (encoder ?? JSONEncoder()).encode(encodable)
      let json = String(data: data, encoding: encoding)
      guard let jsonString = json else {
        throw RxCodableError.castingFailed(data: data, type: String.self)
      }
      return jsonString
    }
  }
}

