import Foundation

public enum AdvancedEnum: Codable {
	case unitVariant
	case anonymousStruct(field1: String)
	case otherAnonymousStruct(field1: UInt32, field2: Float)
	case rename(field3: Bool?)

	enum CodingKeys: String, CodingKey, Codable {
		case unitVariant,
			anonymousStruct = "A",
			otherAnonymousStruct,
			rename = "B"
	}

	private enum ContainerCodingKeys: String, CodingKey {
		case type, field1, field2, field3
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: ContainerCodingKeys.self)
		if let type = try? container.decode(CodingKeys.self, forKey: .type) {
			switch type {
			case .unitVariant:
				self = .unitVariant
				return
			case .anonymousStruct:
				if
					let field1 = try? container.decode(String.self, forKey: .field1)
				{
					self = .anonymousStruct(field1: field1)
					return
				}
			case .otherAnonymousStruct:
				if
					let field1 = try? container.decode(UInt32.self, forKey: .field1),
					let field2 = try? container.decode(Float.self, forKey: .field2)
				{
					self = .otherAnonymousStruct(field1: field1, field2: field2)
					return
				}
			case .rename:
				let field3 = try? container.decodeIfPresent(Bool?.self, forKey: .field3)
				self = .rename(field3: field3)
				return
			}
		}
		throw DecodingError.typeMismatch(AdvancedEnum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AdvancedEnum"))
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: ContainerCodingKeys.self)
		switch self {
		case .unitVariant:
			try container.encode(CodingKeys.unitVariant, forKey: .type)
		case .anonymousStruct(let field1):
			try container.encode(CodingKeys.anonymousStruct, forKey: .type)
			try container.encode(field1, forKey: .field1)
		case .otherAnonymousStruct(let field1, let field2):
			try container.encode(CodingKeys.otherAnonymousStruct, forKey: .type)
			try container.encode(field1, forKey: .field1)
			try container.encode(field2, forKey: .field2)
		case .rename(let field3):
			try container.encode(CodingKeys.rename, forKey: .type)
			try container.encode(field3, forKey: .field3)
		}
	}
}
