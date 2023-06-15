import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grown/app/modules/chiller_reading/branchwise_chiller_reading/views/branchwise_chiller_reading_view.dart';
import 'package:grown/app/modules/chiller_reading/datewise_chiller_reading/views/datewise_chiller_reading_view.dart';
import 'package:grown/app/modules/home/views/home_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/RunNoData/views/run_no_data_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/growing/views/growing_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/post_run/views/post_run_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/views/pre_run_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/view_mlgd_data_run_wise/views/view_mlgd_data_run_wise_view.dart';
import 'package:grown/app/modules/ups_reading/ViewUpsReadingBranchWise/views/view_ups_reading_branch_wise_view.dart';
import 'package:grown/app/modules/ups_reading/ViewUpsReadingDateWise/views/view_ups_reading_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:url_launcher/link.dart';
import '../modules/gas_bank_operator/GasManifold/views/gas_manifold_view.dart';
import '../modules/gas_bank_operator/GasVendor/views/gas_vendor_view.dart';
import '../modules/gas_bank_operator/Gases/views/gases_view.dart';
import '../modules/gas_bank_operator/SearchBySerialNo/views/search_by_serial_no_view.dart';
import '../modules/mlgd_data_monitoring/view_mlgd_data_date_wise/views/view_mlgd_data_date_wise_view.dart';

class Choice {
  Choice({
    this.onTap,
    required this.title,
    this.image,
    this.iconData,
    this.iconColor,
    this.uri

  });

  final String title;
  final String? image;
  final IconData? iconData;
  final Color? iconColor;
  final Function()? onTap;
  final Uri? uri;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h / 4,
      width: w / 2,
      child: GestureDetector(
        onTap: choice.onTap,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (choice.image == null && choice.iconData == null)
                  ? Link(
                      uri: Uri.parse('https://flutter.dev'),
                      builder: (BuildContext context, FollowLink? followLink) =>
                          IconButton(
                        onPressed:(){
                          followLink;
                          print("Hiii");
                        } ,
                        icon: Icon(Icons.email , color: choice.iconColor,),
                        iconSize:10,
                      ),
                    )
                  : Container(),

              (choice.image == null)
                  ? Icon(
                      choice.iconData,
                      color: choice.iconColor,
                      size: w * 0.15,
                    )
                  : Image.asset(
                      choice.image!,
                      height: h * 0.10,
                    ),
              // Icon(choice.icon, size: 26, color: const Color(0xFF716259)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(choice.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color(0xFF6EB7A1),
                    )),
              )
            ]),
      ),
    );
  }
}

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {Key? key,
      this.dropDownItems,
      this.dropDownOnChanged,
      required this.dropDown,
      required this.titleText,
      this.hintText,
      this.maxLines,
      this.textController,
      this.textBoxWidth,
      this.dropDownWidth,
      this.keyboardType,
      this.textBoxHeight,
      this.dropDownHeight,
      this.onTextChanged,
      this.readOnly,
      this.suffixIcon,
      this.onTapTextBox,
      this.borderSideTextBox,
      this.borderSideDropDown,
      this.dropDownValue,
      this.textHintStyle, this.minLines, this.obscureText})
      : super(key: key);
  final List<DropdownMenuItem<Object>>? dropDownItems;
  final Function(Object?)? dropDownOnChanged;
  final bool dropDown;
  final String titleText;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? textController;
  final double? textBoxWidth;
  final double? dropDownWidth;
  final double? textBoxHeight;
  final double? dropDownHeight;
  final TextInputType? keyboardType;
  final Function(String)? onTextChanged;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Function()? onTapTextBox;
  final BorderSide? borderSideTextBox;
  final BorderSide? borderSideDropDown;
  final Object? dropDownValue;
  final TextStyle? textHintStyle;
  final bool? obscureText;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: const TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        (dropDown == true)
            ? Container(
                height: dropDownHeight,
                width: dropDownWidth,
                color: Colors.transparent,
                child: DropdownButtonFormField(
                    value: dropDownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      size: 30,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(
                          borderSide: borderSideDropDown ?? const BorderSide(),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: dropDownItems,
                    onChanged: dropDownOnChanged),
              )
            : Container(
                height: textBoxHeight,
                width: textBoxWidth,
                color: Colors.grey.shade100,
                child: TextFormField(
                  obscureText: obscureText??false,
                  onChanged: onTextChanged,
                  controller: textController,
                  maxLines: maxLines,
                  minLines: minLines ??1,
                  readOnly: readOnly ?? false,
                  keyboardType: keyboardType ?? TextInputType.text,
                  onTap: onTapTextBox,
                  decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    contentPadding: const EdgeInsets.all(10),
                    isDense: (maxLines != null) ? true : false,
                    hintText: hintText ?? "Enter $titleText",
                    hintStyle: textHintStyle,
                    border: OutlineInputBorder(
                      borderSide: borderSideTextBox ?? const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
          width: w,
          child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ))),
    );
  }
}

class MlgdTextFormWidget extends StatelessWidget {
  const MlgdTextFormWidget(
      {Key? key,
      required this.controller,
      required this.title,
      this.onChanged,
      this.validator,
      this.autofocus,
      this.keyboardType,
      this.maxWidth,
      this.readOnly})
      : super(key: key);
  final TextEditingController controller;
  final String title;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final double? maxWidth;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextFormField(
          readOnly: readOnly ?? false,
          autofocus: autofocus ?? false,
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType ?? TextInputType.number,
          decoration: InputDecoration(
              hintText: "Your Answer",
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? double.infinity,
              )),
          controller: controller,
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class MyRadioList extends StatelessWidget {
  const MyRadioList(
      {Key? key,
      this.groupValue,
      this.onChanged,
      required this.title,
      required this.value,
      this.height,
      this.width,
      this.selectedTileColor,
      this.activeColor})
      : super(key: key);
  final Object? groupValue;
  final void Function(Object?)? onChanged;
  final String title;
  final String value;
  final double? height;
  final double? width;
  final Color? selectedTileColor;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RadioListTile(
        selectedTileColor: selectedTileColor,
        contentPadding: EdgeInsets.zero,
        activeColor: activeColor ?? Colors.purple.shade800,
        title: Text(title),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

class MyTextWidget extends StatelessWidget {
  const MyTextWidget(
      {Key? key, required this.title, this.isLines, this.body, this.colors})
      : super(key: key);
  final String title;
  final String? body;
  final bool? isLines;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Card(

      color: colors,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple),
                ),
                Text((body == null) ? "" : body!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          (isLines == false)
              ? Container()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey.withOpacity(0.5)),
        ],
      ),
    );
  }
}

class MlgdReportTabBar extends StatelessWidget {
  const MlgdReportTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("View Data"),
              centerTitle: true,
              toolbarHeight: 60,
              bottom: const TabBar(
                tabs: [
                  Text(
                    "Date Wise",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Run No Wise",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ViewMlgdDataDateWiseView(),
                ViewMlgdDataRunWiseView(),
              ],
            )));
  }
}

class MlgdDataEntryTabBar extends StatelessWidget {
  const MlgdDataEntryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      GrowingView(),
      RunNoDataView(),
      PreRunView(),
      PostRunView(),
    ];
    return DefaultTabController(
        length: children.length,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("Data Entry"),
              centerTitle: true,
              toolbarHeight: 60,
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Text(
                    "Running Data",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "New-Run Data",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Pre-Run Data",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Post-Run Data",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: children,
            )));
  }
}

class UpsReadingTabBar extends StatelessWidget {
  const UpsReadingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text("View Data"),
                centerTitle: true,
                toolbarHeight: 60,
                bottom: const TabBar(
                  tabs: [
                    Text(
                      "Date Wise",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Branch Wise",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ViewUpsReadingDateWiseView(),
                  ViewUpsReadingBranchWiseView()
                ],
              ))),
    );
  }
}

class ChillerReadingTabBar extends StatelessWidget {
  const ChillerReadingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text("View Data"),
                centerTitle: true,
                toolbarHeight: 60,
                bottom: const TabBar(
                  tabs: [
                    Text(
                      "Date Wise",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Branch Wise",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  DateWiseChillerReadingView(),
                  BranchWiseChillerReadingView()
                ],
              ))),
    );
  }
}

class MyBottomNavigation extends StatelessWidget {
  MyBottomNavigation(
      {Key? key,
      required this.title1,
      required this.title2,
      required this.title3,
      required this.title4,
      required this.screens,
      this.iconData1,
      this.iconData2,
      this.iconData3,
      this.iconData4,
      this.image1})
      : super(key: key);
  final RxInt selected = 1.obs;
  final _controller = PersistentTabController(
    initialIndex: 0,
  );
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final IconData? iconData1;
  final IconData? iconData2;
  final IconData? iconData3;
  final IconData? iconData4;
  final String? image1;
  final List<Widget> screens;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        title: title1,
        textStyle: const TextStyle(fontSize: 16),
        iconSize: 25,
        icon: (image1 == null)
            ? Icon(iconData1, size: 30)
            : ImageIcon(AssetImage(image1!), size: 30),
        activeColorPrimary: Colors.purpleAccent,
        // inactiveColorPrimary: Colors.grey,
        // inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        title: title2,
        textStyle: const TextStyle(fontSize: 16),
        icon: Icon(
          iconData2,
          size: 30,
        ),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(fontSize: 16),
        iconSize: 25,
        title: title3,
        icon: Icon(iconData3, size: 30),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(fontSize: 16),
        title: title4,
        iconSize: 25,
        icon: Icon(iconData4, size: 30),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return screens;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (selected.value == 0)
          ? Container()
          : PersistentTabView(
              context,
              controller: _controller,
              items: _navBarsItems(),
              navBarStyle: NavBarStyle.style7,
              screens: _buildScreens(),
              decoration: const NavBarDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      // color: secondaryColor,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 6.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
            ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: CircleAvatar(
              radius: w * 0.1,
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  "assets/images/cblogo.png",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => GasesView()),
              child: const Row(
                children: [
                  Icon(
                    Icons.gas_meter,
                    size: 25,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Gases",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => GasManifoldView()),
              child: const Row(
                children: [
                  Icon(
                    Icons.gas_meter_sharp,
                    color: Colors.teal,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Gas Manifold",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => GasVendorView()),
              child: const Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Gas Vendor",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => SearchBySerialNoView()),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.green,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Search by Serial No",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.offAll(() => HomeView()),
              child: const Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.black87,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextBoxWidget extends StatelessWidget {
  const TextBoxWidget(
      {Key? key,
      required this.controller,
      required this.title,
      this.onChanged,
      this.validator,
      this.autofocus,
      this.keyboardType,
      this.hintText,
      this.height, this.readOnly})
      : super(key: key);
  final TextEditingController controller;
  final String title;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool? autofocus;
  final double? height;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextFormField(
          autofocus: autofocus ?? false,
          validator: validator,
          onChanged: onChanged,
          readOnly: readOnly??false,
          keyboardType: keyboardType ?? TextInputType.number,
          decoration: InputDecoration(
              hintText: hintText ?? "Your Answer",
              hintStyle: (hintText != null)
                  ? const TextStyle(color: Colors.black)
                  : const TextStyle()),
          controller: controller,
        ),
        SizedBox(
          height: height ?? 20,
        )
      ],
    );
  }
}
