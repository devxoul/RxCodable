import Foundation
import Moya
import RxSwift

#if !COCOAPODS
import RxCodable
#endif

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == Moya.Response {
  public func map<T>(
    _ type: T.Type,
    dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
  ) -> PrimitiveSequence<TraitType, T> where T: Decodable {
    return self
      .map { response in response.data }
      .map(type, dataDecodingStrategy: dataDecodingStrategy, dateDecodingStrategy: dateDecodingStrategy)
  }
}
