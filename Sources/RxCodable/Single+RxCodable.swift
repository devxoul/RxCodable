import Foundation
import RxSwift

public extension PrimitiveSequenceType where Trait == SingleTrait, Element == Data {
  func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<Trait, T> where T: Decodable {
    return self.map { data -> T in
      let decoder = decoder ?? JSONDecoder()
      return try decoder.decode(type, from: data)
    }
  }
}

public extension PrimitiveSequenceType where Trait == SingleTrait, Element == String {
  func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<Trait, T> where T: Decodable {
    return self
      .map { string in string.data(using: .utf8) ?? Data() }
      .map(type, using: decoder)
  }
}

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType == [String: Any] {
  public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
    return self
      .map { dict in try JSONSerialization.data(withJSONObject: dict) }
      .map(type, using: decoder)
  }
}

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType == [[String: Any]] {
  public func map<T>(_ type: Array<T>.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, [T]> where T: Decodable {
    return self
      .flatMap {
        Observable.from($0)
          .map(T.self, using: decoder)
          .toArray()
          .asSingle()
      }
  }
}

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType: Encodable {
  public func mapDictionary(_ encoder: JSONEncoder? = nil) -> PrimitiveSequence<TraitType, [String: Any]> {
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

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType: Encodable {
  public func mapJSONString(_ encoder: JSONEncoder? = nil, encoding: String.Encoding = .utf8) -> PrimitiveSequence<TraitType, String> {
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
