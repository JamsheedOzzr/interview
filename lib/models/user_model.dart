class GeoModel {
  final String lat;
  final String lng;

  const GeoModel({required this.lat, required this.lng});

  factory GeoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const GeoModel(lat: '0', lng: '0');
    return GeoModel(
      lat: json['lat']?.toString() ?? '0',
      lng: json['lng']?.toString() ?? '0',
    );
  }
}

class AddressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel geo;

  const AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AddressModel(
        street: '',
        suite: '',
        city: '',
        zipcode: '',
        geo: GeoModel.fromJson(null),
      );
    }
    return AddressModel(
      street: json['street']?.toString() ?? '',
      suite: json['suite']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      zipcode: json['zipcode']?.toString() ?? '',
      geo: GeoModel.fromJson(json['geo'] as Map<String, dynamic>?),
    );
  }
}

class CompanyModel {
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyModel({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory CompanyModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CompanyModel(name: '', catchPhrase: '', bs: '');
    }
    return CompanyModel(
      name: json['name']?.toString() ?? '',
      catchPhrase: json['catchPhrase']?.toString() ?? '',
      bs: json['bs']?.toString() ?? '',
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final AddressModel address;
  final CompanyModel company;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? 'Unknown',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>?),
      company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>?),
    );
  }
}
