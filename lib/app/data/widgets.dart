import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grown/app/modules/home/views/home_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/view_mlgd_data_run_wise/views/view_mlgd_data_run_wise_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../modules/gas_bank_operator/GasManifold/views/gas_manifold_view.dart';
import '../modules/gas_bank_operator/GasMonitor/views/gas_monitor_view.dart';
import '../modules/gas_bank_operator/GasVendor/views/gas_vendor_view.dart';
import '../modules/gas_bank_operator/Gases/views/gases_view.dart';
import '../modules/gas_bank_operator/SearchBySerialNo/views/search_by_serial_no_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mlgd_data_monitoring/view_mlgd_data_date_wise/views/view_mlgd_data_date_wise_view.dart';

class Choice {
  Choice(
      {this.onTap,
      required this.title,
      this.image,
      this.iconData,
      required this.index});

  int index;
  final String title;
  final String? image;
  final IconData? iconData;
  final Function()? onTap;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h / 5,
      width: w / 3,
      child: GestureDetector(
        onTap: choice.onTap,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
            ),
            elevation: 10,
            color: const Color(0xFFF6F6F6),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  (choice.image == null)
                      ? Icon(
                          choice.iconData,
                          size: w * 0.15,
                        )
                      : Image.asset(
                          choice.image!,
                          height: 70,
                          width: 25,
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
                ])),
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
        this.borderSideDropDown, this.dropDownValue, this.textHintStyle})
      : super(key: key);
  final List<DropdownMenuItem<Object>>? dropDownItems;
  final Function(Object?)? dropDownOnChanged;
  final bool dropDown;
  final String titleText;
  final String? hintText;
  final int? maxLines;
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
            onChanged: onTextChanged,
            controller: textController,
            maxLines: maxLines,
            minLines: 1,
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
  const MyCard({Key? key, required this.title, required this.onTap}) : super(key: key);
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
          width: w,
          child:  Card(
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
      {Key? key, required this.controller, required this.title, this.onChanged, this.validator, this.autofocus, this.keyboardType, this.maxWidth})
      : super(key: key);
  final TextEditingController controller;
  final String title;
  final Function(String)? onChanged;
  final String?Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextFormField(
          autofocus: autofocus ?? false,
          validator: validator,
          onChanged: onChanged,
          keyboardType:keyboardType?? TextInputType.number,
          decoration:   InputDecoration(
              hintText: "Your Answer",
              constraints: BoxConstraints(maxWidth:maxWidth?? double.infinity ,)
          ),
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
        this.width, this.selectedTileColor, this.activeColor})
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
        activeColor:activeColor?? Colors.purple.shade800,
        title: Text(title),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

class MyTextWidget extends StatelessWidget {
  const MyTextWidget({Key? key, required this.title, this.isContainer, this.body}) : super(key: key);
  final String title;
  final String? body;
  final bool? isContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10 , right: 10 , top: 8 , bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: Colors.deepPurple),),

              Text((body == null)?"":body!,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 )),
            ],
          ),
        ),
        (isContainer == false)?Container(): Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey.withOpacity(0.5)
        ),
      ],
    );
  }
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key});
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
                    Text("Date Wise" , style: TextStyle(fontSize: 18),),
                    Text("Run No Wise" , style: TextStyle(fontSize: 18),) ,
                  ],
                ),
              ),
              body:  TabBarView(
                children: [
                  ViewMlgdDataDateWiseView(),
                  ViewMlgdDataRunWiseView(),
                ],
              ))),
    );
  }
}

class MyBottomNavigation extends StatelessWidget {
  MyBottomNavigation({Key? key}) : super(key: key);
  final RxInt selected = 1.obs;
  final _controller = PersistentTabController(initialIndex: 0,);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        title: "Gas Monitor",
        textStyle: const TextStyle(fontSize: 16 ),
        iconSize: 25,
        icon: const Icon(Icons.monitor , size: 30,),
        activeColorPrimary: Colors.purpleAccent,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        iconSize: 25,
        title: "Gases",
        textStyle: const TextStyle(fontSize: 16 ),
        icon:const Icon(Icons.gas_meter , size: 30),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,

      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(fontSize: 16 ),
        iconSize: 25,
        title: "Gas Manifold",
        icon: const Icon(Icons.gas_meter_sharp, size: 30,),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(fontSize: 16 ),
        title: "Gas Vendor",
        iconSize: 25,
        icon: const Icon(Icons.person , size: 30,),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        activeColorSecondary: Colors.white,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      GasMonitorView(),
      GasesView(),
      GasManifoldView(),
      GasVendorView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>(selected.value == 0)?Container(): PersistentTabView(
        context,
        controller: _controller,
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style7,
        screens: _buildScreens(),
        decoration: const NavBarDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(5.0, 5.0,),
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
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => GasesView()),
              child: Row(
                children: const [
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
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => GasManifoldView()),
              child: Row(
                children: const [
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
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => GasVendorView()),
              child: Row(
                children: const [
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
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.to(() => SearchBySerialNoView()),
              child: Row(
                children: const [
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
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Get.offAll(()=>HomeView()),
              child: Row(
                children: const [
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
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
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
        this.keyboardType})
      : super(key: key);
  final TextEditingController controller;
  final String title;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  final bool? autofocus;

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
          keyboardType: keyboardType ?? TextInputType.number,
          decoration: const InputDecoration(hintText: "Your Answer"),
          controller: controller,
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}