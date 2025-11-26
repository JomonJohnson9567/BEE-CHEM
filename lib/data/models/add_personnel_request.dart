class AddPersonnelRequest {
  const AddPersonnelRequest({
    required this.fullName,
    required this.address,
    required this.suburb,
    required this.state,
    required this.postcode,
    required this.country,
    required this.contactNumber,
    required this.latitude,
    required this.longitude,
    required this.roleIds,
    required this.additionalNotes,
    required this.isActive,
  });

  Map<String, dynamic> toBody() {
    final body = <String, dynamic>{
      'first_name': fullName,
      'address': address,
      'suburb': suburb,
      'state': state,
      'postcode': postcode,
      'country': country,
      'contact_number': contactNumber,
      'latitude': latitude,
      'longitude': longitude,
      'status': isActive ? '1' : '0',
      'additional_notes': additionalNotes,
    };

    if (roleIds.isNotEmpty) {
      // Send role_ids as comma-separated string for multiple roles
      body['role_ids'] = roleIds.map((id) => id.toString()).join(',');
    }

    return body;
  }

  final String fullName;
  final String address;
  final String suburb;
  final String state;
  final String postcode;
  final String country;
  final String contactNumber;
  final String latitude;
  final String longitude;
  final List<int> roleIds;
  final String additionalNotes;
  final bool isActive;
}
