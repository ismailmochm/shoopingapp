import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/core/theme/app_colors.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../bloc/product_event.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (p, c) => p.sortType != c.sortType,
      builder: (_, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 15.h,
            bottom: 5.h,
          ),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 15.h,
            children: [
              Row(
                children: [
                  Icon(Icons.sort, size: 20.w),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text('Sort By:', style: TextStyle(fontSize: 16.sp)),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<SortType>(
                      initialValue: state.sortType,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.greyLight,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.grey,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.grey,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.grey,
                          ),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                      ),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: SortType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(
                            type.label,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context.read<ProductBloc>().add(SortProducts(value));
                        }
                      },
                    ),
                  ),
                ],
              ),

              Divider(color: AppColors.greyLight, thickness: 1.h),
            ],
          ),
        );
      },
    );
  }
}
