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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final controller = Get.find<CustomerListController>();
    controller.getCustomerListData(pageNumber: 1);

    _scrollController.addListener(() {
      final controller = Get.find<CustomerListController>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !controller.customerDataInProgress &&
          controller.hasMorePages) {
        controller.getCustomerListData(
          pageNumber: controller.currentPage + 1,
          append: true,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Customer List'), centerTitle: true),
      body: GetBuilder<CustomerListController>(
        builder: (controller) {
          final customers = controller.customerList ?? [];

          if (customers.isEmpty && controller.customerDataInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount:
                customers.length + (controller.customerDataInProgress ? 1 : 0),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == customers.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final customer = customers[index];
              final imageUrl =
                  customer.imagePath != null
                      ? '${Urls.imageBaseLink}/${customer.imagePath}'
                      : null;

              return InkWell(
                onTap:
                    () => Get.to(
                      () => CustomerInfoScreen(customerInfo: customer),
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
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl) : null,
                          child:
                              imageUrl == null
                                  ? Text(
                                    customer.name
                                            ?.substring(0, 1)
                                            .toUpperCase() ??
                                        '?',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customer.name ?? 'No Name',
                                style: theme.textTheme.titleMedium?.copyWith(
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
                                      customer.phone ?? 'No phone',
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: Colors.grey[600]),
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
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            customer.custType == 'G' ? 'Group' : 'Local',
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
          );
        },
      ),
    );
  }
}
