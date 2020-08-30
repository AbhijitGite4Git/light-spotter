/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Cameras : Codable {
	var timestamp : String = ""
	var image : String = ""
    var location : Location = Location()
	var camera_id : String = ""
	var image_metadata : Image_metadata = Image_metadata()

	enum CodingKeys: String, CodingKey {

		case timestamp = "timestamp"
		case image = "image"
		case location = "location"
		case camera_id = "camera_id"
		case image_metadata = "image_metadata"
	}

  
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)!
        image = try values.decodeIfPresent(String.self, forKey: .image)!
        location = try values.decodeIfPresent(Location.self, forKey: .location)!
        camera_id = try values.decodeIfPresent(String.self, forKey: .camera_id)!
        image_metadata = try values.decodeIfPresent(Image_metadata.self, forKey: .image_metadata)!
	}
    
    init() { }
  

}
