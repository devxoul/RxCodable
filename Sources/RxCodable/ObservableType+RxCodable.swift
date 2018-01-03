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

public extension ObservableType where E: Encodable {
  public func toDictionary(_ encoder: JSONEncoder? = nil) -> Observable<[String: Any]> {
    return self.map { encodable -> [String: Any] in
      let data = try (encoder ?? JSONEncoder()).encode(encodable)
      let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
      guard let dictionary = dict else { throw RxError.noElements }
      return dictionary
    }
  }
}

public extension ObservableType where E: Encodable {
  public func toJSONString(_ encoding: String.Encoding = .utf8, using encoder: JSONEncoder? = nil) -> Observable<String> {
    return self.map { encodable -> String in
      let data = try (encoder ?? JSONEncoder()).encode(encodable)
      let json = String(data: data, encoding: encoding)
      return json ?? "{}"
    }
  }
}

