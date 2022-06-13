/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DataBannerImageModel : Codable
{
	let redirect : String?
	let aNDROID_FORCE_UPDATE : String?
	let aNDROID_UPDATE_MESSAGE : String?
	let iOS_FORCE_UPDATE : String?
	let iOS_UPDATE_MESSAGE : String?
	let currency_symbol : String?
	let params : String?
	let headers : String?
	let banner_list : [BannerlistModel]?

	enum CodingKeys: String, CodingKey {

		case redirect = "redirect"
		case aNDROID_FORCE_UPDATE = "ANDROID_FORCE_UPDATE"
		case aNDROID_UPDATE_MESSAGE = "ANDROID_UPDATE_MESSAGE"
		case iOS_FORCE_UPDATE = "IOS_FORCE_UPDATE"
		case iOS_UPDATE_MESSAGE = "IOS_UPDATE_MESSAGE"
		case currency_symbol = "currency_symbol"
		case params = "params"
		case headers = "headers"
		case banner_list = "banner_list"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		redirect = try values.decodeIfPresent(String.self, forKey: .redirect)
		aNDROID_FORCE_UPDATE = try values.decodeIfPresent(String.self, forKey: .aNDROID_FORCE_UPDATE)
		aNDROID_UPDATE_MESSAGE = try values.decodeIfPresent(String.self, forKey: .aNDROID_UPDATE_MESSAGE)
		iOS_FORCE_UPDATE = try values.decodeIfPresent(String.self, forKey: .iOS_FORCE_UPDATE)
		iOS_UPDATE_MESSAGE = try values.decodeIfPresent(String.self, forKey: .iOS_UPDATE_MESSAGE)
		currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
		params = try values.decodeIfPresent(String.self, forKey: .params)
		headers = try values.decodeIfPresent(String.self, forKey: .headers)
		banner_list = try values.decodeIfPresent([BannerlistModel].self, forKey: .banner_list)
	}

}
