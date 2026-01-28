import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/widgets/success_dialog.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';

class Footer extends StatelessWidget {
  final double total;
  const Footer({required this.total, super.key});

  @override
  Widget build(BuildContext context) {
    final enabled = total > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Total:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              const Spacer(),
              Text(
                'Rp. ${total.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: enabled ? Colors.black87 : Colors.grey.shade300,
              minimumSize: Size(double.infinity, 42.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.r),
              ),
            ),
            onPressed: enabled ? () => _checkout(context) : null,
            child: Text('Checkout', style: TextStyle(fontSize: 16.sp)),
          ),
          if (enabled) ...[
            const SizedBox(height: 8),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 42.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48.r),
                ),
              ),
              onPressed: () => context.read<ProductBloc>().add(ResetCart()),
              child: Text('Reset', style: TextStyle(fontSize: 16.sp)),
            ),
          ],
        ],
      ),
    );
  }

  void _checkout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: context.read<ProductBloc>(),
        child: const SuccessDialog(),
      ),
    );
  }
}
