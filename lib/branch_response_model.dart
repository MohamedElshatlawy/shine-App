class ResponseModel {
	bool status;
	String code;
	String message;
	Branches branches;

	ResponseModel({this.status, this.code, this.message, this.branches});

	ResponseModel.fromJson(Map<String, dynamic> json) {
		status = json['status'];
		code = json['code'];
		message = json['message'];
		branches = json['branches'] != null ? new Branches.fromJson(json['branches']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = this.status;
		data['code'] = this.code;
		data['message'] = this.message;
		if (this.branches != null) {
      data['branches'] = this.branches.toJson();
    }
		return data;
	}
}

class Branches {
	int currentPage;
	List<Data> data;
	String firstPageUrl;
	int from;
	int lastPage;
	String lastPageUrl;
	String nextPageUrl;
	String path;
	int perPage;
	String prevPageUrl;
	int to;
	int total;

	Branches({this.currentPage, this.data, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});

	Branches.fromJson(Map<String, dynamic> json) {
		currentPage = json['current_page'];
		if (json['data'] != null) {
			data = new List<Data>();
			json['data'].forEach((v) { data.add(new Data.fromJson(v)); });
		}
		firstPageUrl = json['first_page_url'];
		from = json['from'];
		lastPage = json['last_page'];
		lastPageUrl = json['last_page_url'];
		nextPageUrl = json['next_page_url'];
		path = json['path'];
		perPage = json['per_page'];
		prevPageUrl = json['prev_page_url'];
		to = json['to'];
		total = json['total'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['current_page'] = this.currentPage;
		if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
		data['first_page_url'] = this.firstPageUrl;
		data['from'] = this.from;
		data['last_page'] = this.lastPage;
		data['last_page_url'] = this.lastPageUrl;
		data['next_page_url'] = this.nextPageUrl;
		data['path'] = this.path;
		data['per_page'] = this.perPage;
		data['prev_page_url'] = this.prevPageUrl;
		data['to'] = this.to;
		data['total'] = this.total;
		return data;
	}
}

class Data {
	int id;
	String lat;
	String lng;
	Title title;
	Title description;
  OpenTime openTime;
	String address;
	String phone;
	String image;
	String cover;
  bool home_service;
	int rate;
	bool favorite;
	String email;
	String facebook;
	String twitter;
	String instagram;
	User user;
	List<Null> stylists;
	List<Null> services;
	List<Null> products;
	List<Null> posts;
	List<Rates> rates;

	Data({this.id, this.lat, this.lng, this.title, this.description, this.address, this.phone, this.image, this.cover, this.rate, this.favorite, this.email, this.facebook, this.twitter, this.instagram, this.user, this.stylists, this.services, this.products, this.posts, this.rates});

	Data.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		lat = json['lat'];
		lng = json['lng'];
		title = json['title'] != null ? new Title.fromJson(json['title']) : null;
		description = json['description'] != null ? new Title.fromJson(json['description']) : null;
    openTime = json['open_time'] != null ? new OpenTime.fromJson(json['open_time']): null;
		address = json['address'];
		phone = json['phone'];
		image = json['image'];
		cover = json['cover'];
		rate = json['rate'];
		favorite = json['favorite'];
		email = json['email'];
    home_service=json['home_service'];
		facebook = json['facebook'];
		twitter = json['twitter'];
		instagram = json['instagram'];
		user = json['user'] != null ? new User.fromJson(json['user']) : null;
		// if (json['stylists'] != null) {
		// 	stylists = new List<Null>();
    //   //Edited
		// 	json['stylists'].forEach((v) { stylists.add(null); });
		// }
		// if (json['services'] != null) {
		// 	services = new List<Null>();
    //   //Edited
      
		// 	json['services'].forEach((v) { services.add(null); });
		// }
		// if (json['products'] != null) {
		// 	products = new List<Null>();
		// 	json['products'].forEach((v) { products.add(null); });
		// }
		// if (json['posts'] != null) {
		// 	posts = new List<Null>();
		// 	json['posts'].forEach((v) { posts.add(null); });
		// }

		if (json['rates'] != null) {
			rates = new List<Rates>();
			json['rates'].forEach((v) { rates.add(new Rates.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['lat'] = this.lat;
		data['lng'] = this.lng;
		if (this.title != null) {
      data['title'] = this.title.toJson();
    }
		if (this.description != null) {
      data['description'] = this.description.toJson();
    }
		data['address'] = this.address;
		data['phone'] = this.phone;
		data['image'] = this.image;
		data['cover'] = this.cover;
		data['rate'] = this.rate;
		data['favorite'] = this.favorite;
		data['email'] = this.email;
		data['facebook'] = this.facebook;
		data['twitter'] = this.twitter;
		data['instagram'] = this.instagram;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		if (this.stylists != null) {
      data['stylists'] = this.stylists.map((v) => null).toList();
    }
		if (this.services != null) {
      data['services'] = this.services.map((v) => null).toList();
    }
		if (this.products != null) {
      data['products'] = this.products.map((v) => null).toList();
    }
		if (this.posts != null) {
      data['posts'] = this.posts.map((v) => null).toList();
    }
		if (this.rates != null) {
      data['rates'] = this.rates.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Title {
  String ar;

  Title({this.ar});

  Title.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    return data;
  }
}

class OpenTime{
  String from;
  String to;

  OpenTime({this.from,this.to});
  OpenTime.fromJson(Map<String, dynamic> json) {
  
    from=json['from'];
    to=json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to']=this.to;
    return data;
  }

}
class User {
  int id;
  String email;
  String phone;
  int isVerified;
  int isLogin;
  int isActive;
  String fbgId;
  String status;
  String lat;
  String lng;
  String createdAt;
  String updatedAt;
  bool vendor;
  bool customer;
  bool freelancer;
  String firstName;
  String lastName;
  String address;
  String latitude;
  String longitude;
  String image;
  String notification;
  String facebook;
  String twitter;
  String instagram;

  User(
      {this.id,
      this.email,
      this.phone,
      this.isVerified,
      this.isLogin,
      this.isActive,
      this.fbgId,
      this.status,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.vendor,
      this.customer,
      this.freelancer,
      this.firstName,
      this.lastName,
      this.address,
      this.latitude,
      this.longitude,
      this.image,
      this.notification,
      this.facebook,
      this.twitter,
      this.instagram});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    isVerified = json['is_verified'];
    isLogin = json['is_login'];
    isActive = json['is_active'];
    fbgId = json['fbg_id'];
    status = json['status'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendor = json['vendor'];
    customer = json['customer'];
    freelancer = json['freelancer'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    notification = json['notification'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['is_verified'] = this.isVerified;
    data['is_login'] = this.isLogin;
    data['is_active'] = this.isActive;
    data['fbg_id'] = this.fbgId;
    data['status'] = this.status;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vendor'] = this.vendor;
    data['customer'] = this.customer;
    data['freelancer'] = this.freelancer;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    data['notification'] = this.notification;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    return data;
  }
}


// class User {
// 	int id;
// 	String email;
// 	String phone;
// 	int isVerified;
// 	int isLogin;
// 	int isActive;
// 	String fbgId;
// 	String status;
// 	Null lat;
// 	Null lng;
// 	String createdAt;
// 	String updatedAt;
// 	bool vendor;
// 	bool customer;
// 	bool freelancer;
// 	String firstName;
// 	String lastName;
// 	String address;
// 	String latitude;
// 	String longitude;
// 	Null country;
// 	Null city;
// 	String deviceId;
// 	String deviceType;
// 	String image;
// 	Null notification;

// 	User({this.id, this.email, this.phone, this.isVerified, this.isLogin, this.isActive, this.fbgId, this.status, this.lat, this.lng, this.createdAt, this.updatedAt, this.vendor, this.customer, this.freelancer, this.firstName, this.lastName, this.address, this.latitude, this.longitude, this.country, this.city, this.deviceId, this.deviceType, this.image, this.notification});

// 	User.fromJson(Map<String, dynamic> json) {
// 		id = json['id'];
// 		email = json['email'];
// 		phone = json['phone'];
// 		isVerified = json['is_verified'];
// 		isLogin = json['is_login'];
// 		isActive = json['is_active'];
// 		fbgId = json['fbg_id'];
// 		status = json['status'];
// 		lat = json['lat'];
// 		lng = json['lng'];
// 		createdAt = json['created_at'];
// 		updatedAt = json['updated_at'];
// 		vendor = json['vendor'];
// 		customer = json['customer'];
// 		freelancer = json['freelancer'];
// 		firstName = json['first_name'];
// 		lastName = json['last_name'];
// 		address = json['address'];
// 		latitude = json['latitude'];
// 		longitude = json['longitude'];
// 		country = json['country'];
// 		city = json['city'];
// 		deviceId = json['device_id'];
// 		deviceType = json['device_type'];
// 		image = json['image'];
// 		notification = json['notification'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['id'] = this.id;
// 		data['email'] = this.email;
// 		data['phone'] = this.phone;
// 		data['is_verified'] = this.isVerified;
// 		data['is_login'] = this.isLogin;
// 		data['is_active'] = this.isActive;
// 		data['fbg_id'] = this.fbgId;
// 		data['status'] = this.status;
// 		data['lat'] = this.lat;
// 		data['lng'] = this.lng;
// 		data['created_at'] = this.createdAt;
// 		data['updated_at'] = this.updatedAt;
// 		data['vendor'] = this.vendor;
// 		data['customer'] = this.customer;
// 		data['freelancer'] = this.freelancer;
// 		data['first_name'] = this.firstName;
// 		data['last_name'] = this.lastName;
// 		data['address'] = this.address;
// 		data['latitude'] = this.latitude;
// 		data['longitude'] = this.longitude;
// 		data['country'] = this.country;
// 		data['city'] = this.city;
// 		data['device_id'] = this.deviceId;
// 		data['device_type'] = this.deviceType;
// 		data['image'] = this.image;
// 		data['notification'] = this.notification;
// 		return data;
// 	}
// }



class Rates {
	int id;
	String class1;
	int parentId;
	int userId;
	String value;
	String comment;
	String createdAt;
	String updatedAt;

	Rates({this.id, this.class1, this.parentId, this.userId, this.value, this.comment, this.createdAt, this.updatedAt});

	Rates.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		class1 = json['class'];
		parentId = json['parent_id'];
		userId = json['user_id'];
		value = json['value'];
		comment = json['comment'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['class'] = this.class1;
		data['parent_id'] = this.parentId;
		data['user_id'] = this.userId;
		data['value'] = this.value;
		data['comment'] = this.comment;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		return data;
	}
}

