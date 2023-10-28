import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sales.dart';
import '../widgets/category_products_charts.dart';
import '../widgets/loader.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final Adminservices adminservices = Adminservices();
  List<Sales>? earnings;
  int? totalSales;
  void initState() {
    // TODO: implement initState
    super.initState();

    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminservices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Center(
                child: Text("\$${totalSales}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              CategoryProductCharts(earnings)
            ],
          );
  }
}
