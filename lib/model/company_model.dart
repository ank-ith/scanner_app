import 'package:flutter/foundation.dart';
import '../model/company_model.dart';

// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyModel companyModelFromJson(String str) => CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  final String name;
  final String companyName;
  final bool isPinned;

  CompanyModel({
    required this.name,
    required this.companyName,
    required this.isPinned,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    name: json["name"],
    companyName: json["companyName"],
    isPinned: json["isPinned"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "companyName": companyName,
    "isPinned": isPinned,
  };
}

class NetworkProvider extends ChangeNotifier {
  List<CompanyModel> _networks = [
    CompanyModel(
      name: 'Vishal Pandey',
      companyName: 'Google',
      isPinned: true,
    ),
    CompanyModel(
      name: 'Rajesh Kumar',
      companyName: 'Tesla',
      isPinned: false,
    ),
    CompanyModel(
      name: 'Akash Sharma',
      companyName: 'JP Morgan Chase',
      isPinned: true,
    ),
    CompanyModel(
      name: 'Sanjay Dubey',
      companyName: 'Amazon',
      isPinned: false,
    ),
    CompanyModel(
      name: 'Rohit Verma',
      companyName: 'Netflix',
      isPinned: true,
    ),
  ];

  List<CompanyModel> get networks => _networks;

  List<CompanyModel> get filteredCompanies => _filteredCompanies;
  List<CompanyModel> _filteredCompanies = [];

  void filterCompanies(String query) {
    _filteredCompanies = _networks.where((company) {
      return company.name.toLowerCase().contains(query.toLowerCase()) ||
          company.companyName.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void showAllCompanies() {
    _filteredCompanies = List.from(_networks);
    notifyListeners();
  }

  void showPinnedCompanies() {
    _filteredCompanies = _networks.where((company) => company.isPinned).toList();
    notifyListeners();
  }

  void showSavedCompanies() {
    _filteredCompanies = _networks.where((company) => company.isPinned).toList(); // Modify this logic as needed
    notifyListeners();
  }

  void addToNetwork(CompanyModel item) {
    if (!_networks.contains(item)) {
      _networks.add(item);
      notifyListeners();
    }
  }

  void removeNetwork(CompanyModel item) {
    _networks.remove(item);
    _filteredCompanies.remove(item);
    notifyListeners();
  }
}
