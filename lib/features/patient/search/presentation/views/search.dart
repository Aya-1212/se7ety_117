import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_icons.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/patient/search/presentation/widgets/search_for_doctor_list.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var searchController = TextEditingController();
  int length = -1;

  @override
  void initState() {
    searchController.text = '';
    length = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'بحث عن دكتور',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          TextField(
            style: getBodyStyle(),
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.search, color: AppColors.primary),
              hintText: "البحث",
              hintStyle: getSmallStyle(color: AppColors.black, fontSize: 16),
            ),
            controller: searchController,
            onChanged: (value) {
              // print(value.length);
              setState(() {
                searchController.text = value;
                length = value.length;
              });
            },
          ),
          length == -1
              ? Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        TextButton(
                            onPressed: () {
                              setState(() {
                                length = 1;
                              });
                            },
                            child: Text(
                              "عرض كل الدكاتره",
                              style: getBodyStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold),
                            )),
                        const Gap(10),
                        SvgPicture.asset(
                          AssetsIcons.noSearch,
                          width: 250,
                        ),
                      ],
                    ),
                  ),
                )
              : SearchForDoctorList(searchController: searchController),
        ]),
      ),
    );
  }
}
