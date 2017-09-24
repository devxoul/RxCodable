import Foundation
import RxSwift

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == Data {
  public func map<T>(
    _ type: T.Type,
    dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
  ) -> PrimitiveSequence<TraitType, T> where T: Decodable {
    return self.map { data -> T in
      let decoder = JSONDecoder()
      decoder.dataDecodingStrategy = dataDecodingStrategy
      decoder.dateDecodingStrategy = dateDecodingStrategy
      return try decoder.decode(type, from: data)
    }
  }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == String {
  public func map<T>(
    _ type: T.Type,
    dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
  ) -> PrimitiveSequence<TraitType, T> where T: Decodable {
    return self
      .map { string in string.data(using: .utf8) ?? Data() }
      .map(type, dataDecodingStrategy: dataDecodingStrategy, dateDecodingStrategy: dateDecodingStrategy)
  }
}

