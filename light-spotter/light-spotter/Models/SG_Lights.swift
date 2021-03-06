

import Foundation
struct SG_Lights : Codable {
	let items : [Items]?
	let api_info : Api_info?

	enum CodingKeys: String, CodingKey {

		case items = "items"
		case api_info = "api_info"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		items = try values.decodeIfPresent([Items].self, forKey: .items)
		api_info = try values.decodeIfPresent(Api_info.self, forKey: .api_info)
	}

}
