

import Foundation
struct Location : Codable {
    var latitude : Double  = 1.2752977149006
    var longitude : Double = 103.866390381759

	enum CodingKeys: String, CodingKey {

		case latitude = "latitude"
		case longitude = "longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)!
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)!
	}

    init() {}
    
}
