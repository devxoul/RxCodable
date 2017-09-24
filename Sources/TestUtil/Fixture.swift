public struct User: Codable, Equatable {
  public let id: Int
  public let name: String

  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }

  public enum CodingKeys: String, CodingKey {
    case id
    case name
  }

  public static func == (lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
  }
}
