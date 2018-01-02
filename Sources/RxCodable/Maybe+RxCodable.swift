import Foundation
import RxSwift

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == Data {
  public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
    return self.map { data -> T in
      let decoder = decoder ?? JSONDecoder()
      return try decoder.decode(type, from: data)
    }
  }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == String {
  public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
    return self
      .map { string in string.data(using: .utf8) ?? Data() }
      .map(type, using: decoder)
  }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == [String: Any] {
  public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
    return self
      .map { dict in try JSONSerialization.data(withJSONObject: dict) }
      .map(type, using: decoder)
  }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType: Encodable {
  public func toDictionary() -> PrimitiveSequence<TraitType, [String:Any]> {
    return self.map { encodable -> [String: Any] in
      let data = try JSONEncoder().encode(encodable)
      let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
      return dictionary ?? [:]
    }
  }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType: Encodable {
  public func toJSONString(_ encoding: String.Encoding = .utf8) -> PrimitiveSequence<TraitType, String> {
    return self.map { encodable -> String in
      let data = try JSONEncoder().encode(encodable)
      let json = String(data: data, encoding: encoding)
      return json ?? "{}"
    }
  }
}
