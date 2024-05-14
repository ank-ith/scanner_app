import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/widgets/dismissable_tile.dart';

import '../model/company_model.dart';

class NetWorkingScreen extends StatelessWidget {
  const NetWorkingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212835),
      appBar: AppBar(
        backgroundColor: const Color(0xff212835),
        toolbarHeight: 180,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Search for your Saved companies here',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Consumer<NetworkProvider>(
                    builder: (context, networkProvider, child) {
                      return TextFormField(
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          // Update filteredData based on the search query
                          networkProvider.filterCompanies(value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          hintText: 'Search',
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_align_center, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterChip(
                  label: const Text(
                    'View All',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.deepPurple,
                  onSelected: (selected) {
                    // Show all companies
                    Provider.of<NetworkProvider>(context, listen: false).showAllCompanies();
                  },
                ),
                FilterChip(
                  label: const Text(
                    'Pinned',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                  onSelected: (selected) {
                    // Show pinned companies
                    Provider.of<NetworkProvider>(context, listen: false).showPinnedCompanies();
                  },
                ),
                FilterChip(
                  label: const Text(
                    'Saved',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                  onSelected: (selected) {
                    // Show saved companies
                    Provider.of<NetworkProvider>(context, listen: false).showSavedCompanies();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer<NetworkProvider>(
        builder: (context, networkProvider, child) {
          final List<CompanyModel> filteredCompanies = networkProvider.filteredCompanies;
          return ListView.builder(
            itemCount: filteredCompanies.length,
            itemBuilder: (context, index) {
              final company = filteredCompanies[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  onDismissed: (direction) {
                    // Remove company when dismissed
                    networkProvider.removeNetwork(company);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item dismissed'),
                      ),
                    );
                  },
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  key: ValueKey(company),
                  child: DismissTile(
                    name: company.name,
                    companyName: company.companyName,
                    image: "https://i.pinimg.com/564x/76/f8/0c/76f80c03ec446cb4499c565d749b7b2b.jpg",
                    isPinned: company.isPinned,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
