import 'package:assignment/data/models/customer_list_model.dart';
import 'package:assignment/data/utils/urls.dart';
import 'package:flutter/material.dart';

class CustomerInfoScreen extends StatelessWidget {
  const CustomerInfoScreen({super.key, required this.customerInfo});

  final CustomerList customerInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl =
        customerInfo.imagePath != null
            ? '${Urls.imageBaseLink}/${customerInfo.imagePath}'
            : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(customerInfo.name ?? 'Customer Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      imageUrl != null ? NetworkImage(imageUrl) : null,
                  backgroundColor: Colors.teal.shade100,
                  child:
                      imageUrl == null
                          ? Text(
                            customerInfo.name?.substring(0, 1).toUpperCase() ??
                                '?',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                          : null,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Name
            Text(
              customerInfo.name ?? 'N/A',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 1),

            _infoTile(
              context,
              icon: Icons.phone,
              label: 'Phone',
              value: customerInfo.phone ?? 'Not Provided',
            ),
            _infoTile(
              context,
              icon: Icons.email,
              label: 'Email',
              value: customerInfo.email ?? 'Not Provided',
            ),
            _infoTile(
              context,
              icon: Icons.location_on,
              label: 'Primary Address',
              value: customerInfo.primaryAddress ?? 'Not Provided',
            ),
            _infoTile(
              context,
              icon: Icons.location_on_outlined,
              label: 'Secondary Address',
              value: customerInfo.secoundaryAddress ?? 'Not Provided',
            ),
            _infoTile(
              context,
              icon: Icons.info_outline,
              label: 'Notes',
              value: customerInfo.notes ?? 'None',
            ),
            _infoTile(
              context,
              icon: Icons.business,
              label: 'Client Company',
              value: customerInfo.clinetCompanyName ?? 'N/A',
            ),
            _infoTile(
              context,
              icon: Icons.account_tree,
              label: 'Customer Type',
              value: customerInfo.custType ?? 'N/A',
            ),
            _infoTile(
              context,
              icon: Icons.groups,
              label: 'Parent Customer',
              value: customerInfo.parentCustomer ?? 'N/A',
            ),
            _infoTile(
              context,
              icon: Icons.attach_money,
              label: 'Total Due',
              value:
                  customerInfo.totalDue != null
                      ? '৳ ${customerInfo.totalDue!.toStringAsFixed(2)}'
                      : '0.00',
            ),
            _infoTile(
              context,
              icon: Icons.date_range,
              label: 'Last Transaction',
              value: customerInfo.lastTransactionDate ?? 'N/A',
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Reusable info row widget
  Widget _infoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
