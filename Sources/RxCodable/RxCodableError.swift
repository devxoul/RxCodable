import Foundation

public enum RxCodableError: Error {
  case castingFailed(data: Any, type: Any.Type)
}
