

import Foundation
struct Image_metadata : Codable {
    var height : Int = 10
    var width : Int = 10
	var md5 : String = ""

	enum CodingKeys: String, CodingKey {

		case height = "height"
		case width = "width"
		case md5 = "md5"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height)!
        width = try values.decodeIfPresent(Int.self, forKey: .width)!
        md5 = try values.decodeIfPresent(String.self, forKey: .md5)!
	}
    
    init() {}

}
