import 'package:assignment/data/utils/urls.dart';
import 'package:assignment/features/customer_info/ui/screens/customer_info_screen.dart';
import 'package:assignment/features/customer_list/ui/controllers/customer_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    super.initState();
    _getCustomerList();
  }

  void _getCustomerList() async {
    await Get.find<CustomerListController>().getCustomerListData(pageNumber: 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Customer List'), centerTitle: true),
      body: GetBuilder<CustomerListController>(
        builder: (controller) {
          if (controller.custoemrDataInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          final customers = controller.customerList ?? [];

          return Column(
            children: [
              // Customer List
              Expanded(
                child:
                    customers.isEmpty
                        ? Center(
                          child: Text(
                            'No customers available.',
                            style: theme.textTheme.bodyLarge,
                          ),
                        )
                        : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: customers.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final customer = customers[index];
                            final imageUrl =
                                customer.imagePath != null
                                    ? '${Urls.imageBaseLink}/${customer.imagePath}'
                                    : null;

                            return InkWell(
                              onTap:
                                  () => Get.to(
                                    () => CustomerInfoScreen(
                                      customerInfo: customer,
                                    ),
                                  ),
                              borderRadius: BorderRadius.circular(12),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    children: [
                                      // Avatar
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.grey[300],
                                        backgroundImage:
                                            imageUrl != null
                                                ? NetworkImage(imageUrl)
                                                : null,
                                        child:
                                            imageUrl == null
                                                ? Text(
                                                  customer.name
                                                          ?.substring(0, 1)
                                                          .toUpperCase() ??
                                                      '?',
                                                  style: theme
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        color: Colors.white,
                                                      ),
                                                )
                                                : null,
                                      ),
                                      const SizedBox(width: 16),

                                      // Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              customer.name ?? 'No Name',
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  size: 14,
                                                  color: Colors.grey[600],
                                                ),
                                                const SizedBox(width: 4),
                                                Expanded(
                                                  child: Text(
                                                    customer.phone ??
                                                        'No phone',
                                                    style: theme
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.attach_money,
                                                  size: 14,
                                                  color: Colors.grey[600],
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'Due: ৳${customer.totalDue?.toStringAsFixed(2) ?? "0.00"}',
                                                  style: theme
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: Colors.redAccent,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Type chip
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              customer.custType == 'G'
                                                  ? Colors.blue.shade100
                                                  : Colors.green.shade100,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          customer.custType == 'G'
                                              ? 'Group'
                                              : 'Local',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                customer.custType == 'G'
                                                    ? Colors.blue.shade800
                                                    : Colors.green.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),

              // Pagination
              if (controller.pageInfo != null)
                Container(
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.pageInfo!.pageCount!,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final page = index + 1;
                      final isActive = controller.currentPage == page;

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isActive
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.surfaceVariant,
                          foregroundColor:
                              isActive
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                          elevation: isActive ? 3 : 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onPressed: () {
                          controller.getCustomerListData(pageNumber: page);
                        },
                        child: Text(
                          '$page',
                          style: TextStyle(
                            fontWeight:
                                isActive ? FontWeight.bold : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
