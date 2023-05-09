import 'package:get/get.dart';

import '../modules/bcdi_classification/bindings/bcdi_classification_binding.dart';
import '../modules/bcdi_classification/views/bcdi_classification_view.dart';
import '../modules/bcdi_detection/bindings/bcdi_detection_binding.dart';
import '../modules/bcdi_detection/views/bcdi_detection_view.dart';
import '../modules/camera_application/bindings/camera_application_binding.dart';
import '../modules/camera_application/views/camera_application_view.dart';
import '../modules/chiller_reading/bindings/chiller_reading_binding.dart';
import '../modules/chiller_reading/views/chiller_reading_view.dart';
import '../modules/employee_management/bindings/employee_management_binding.dart';
import '../modules/employee_management/branch_data/bindings/branch_data_binding.dart';
import '../modules/employee_management/branch_data/views/branch_data_view.dart';
import '../modules/employee_management/electrical_employee_management/bindings/electrical_employee_management_binding.dart';
import '../modules/employee_management/electrical_employee_management/views/electrical_employee_management_view.dart';
import '../modules/employee_management/gas_employee_management/bindings/gas_employee_management_binding.dart';
import '../modules/employee_management/gas_employee_management/views/gas_employee_management_view.dart';
import '../modules/employee_management/it_employee_management/bindings/it_employee_management_binding.dart';
import '../modules/employee_management/it_employee_management/views/it_employee_management_view.dart';
import '../modules/employee_management/lab_employee_management/bindings/lab_employee_management_binding.dart';
import '../modules/employee_management/lab_employee_management/designation_lab_employee_management/bindings/designation_lab_employee_management_binding.dart';
import '../modules/employee_management/lab_employee_management/designation_lab_employee_management/views/designation_lab_employee_management_view.dart';
import '../modules/employee_management/lab_employee_management/special_skill_lab_employee_management/bindings/special_skill_lab_employee_management_binding.dart';
import '../modules/employee_management/lab_employee_management/special_skill_lab_employee_management/views/special_skill_lab_employee_management_view.dart';
import '../modules/employee_management/lab_employee_management/views/lab_employee_management_view.dart';
import '../modules/employee_management/views/employee_management_view.dart';
import '../modules/gas_bank_operator/GasManifold/bindings/gas_manifold_binding.dart';
import '../modules/gas_bank_operator/GasManifold/views/gas_manifold_view.dart';
import '../modules/gas_bank_operator/GasMonitor/bindings/gas_monitor_binding.dart';
import '../modules/gas_bank_operator/GasMonitor/views/gas_monitor_view.dart';
import '../modules/gas_bank_operator/GasVendor/bindings/gas_vendor_binding.dart';
import '../modules/gas_bank_operator/GasVendor/views/gas_vendor_view.dart';
import '../modules/gas_bank_operator/Gases/bindings/gases_binding.dart';
import '../modules/gas_bank_operator/Gases/views/gases_view.dart';
import '../modules/gas_bank_operator/SearchBySerialNo/bindings/search_by_serial_no_binding.dart';
import '../modules/gas_bank_operator/SearchBySerialNo/views/search_by_serial_no_view.dart';
import '../modules/gas_bank_operator/bindings/gas_bank_operator_binding.dart';
import '../modules/gas_bank_operator/views/gas_bank_operator_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mlgd_data_monitoring/MlgdBottomNavigation/bindings/mlgd_bottom_navigation_binding.dart';
import '../modules/mlgd_data_monitoring/MlgdBottomNavigation/views/mlgd_bottom_navigation_view.dart';
import '../modules/mlgd_data_monitoring/RunNoData/bindings/run_no_data_binding.dart';
import '../modules/mlgd_data_monitoring/RunNoData/views/run_no_data_view.dart';
import '../modules/mlgd_data_monitoring/bindings/mlgd_data_monitoring_binding.dart';
import '../modules/mlgd_data_monitoring/view_mlgd_data_date_wise/bindings/view_mlgd_data_date_wise_binding.dart';
import '../modules/mlgd_data_monitoring/view_mlgd_data_date_wise/views/view_mlgd_data_date_wise_view.dart';
import '../modules/mlgd_data_monitoring/view_mlgd_data_run_wise/bindings/view_mlgd_data_run_wise_binding.dart';
import '../modules/mlgd_data_monitoring/view_mlgd_data_run_wise/views/view_mlgd_data_run_wise_view.dart';
import '../modules/mlgd_data_monitoring/views/mlgd_data_monitoring_view.dart';
import '../modules/ups_reading/ViewUpsReadingBranchWise/bindings/view_ups_reading_branch_wise_binding.dart';
import '../modules/ups_reading/ViewUpsReadingBranchWise/views/view_ups_reading_branch_wise_view.dart';
import '../modules/ups_reading/ViewUpsReadingDateWise/bindings/view_ups_reading_binding.dart';
import '../modules/ups_reading/ViewUpsReadingDateWise/views/view_ups_reading_view.dart';
import '../modules/ups_reading/bindings/ups_reading_binding.dart';
import '../modules/ups_reading/upsData/bindings/ups_data_binding.dart';
import '../modules/ups_reading/upsData/views/ups_data_view.dart';
import '../modules/ups_reading/views/ups_reading_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BCDI_DETECTION,
      page: () => BcdiDetectionView(),
      binding: BcdiDetectionBinding(),
    ),
    GetPage(
      name: _Paths.BCDI_CLASSIFICATION,
      page: () => BcdiClassificationView(),
      binding: BcdiClassificationBinding(),
    ),
    GetPage(
      name: _Paths.EMPLOYEE_MANAGEMENT,
      page: () => EmployeeManagementView(),
      binding: EmployeeManagementBinding(),
      children: [
        GetPage(
          name: _Paths.LAB_EMPLOYEE_MANAGEMENT,
          page: () => LabEmployeeManagementView(),
          binding: LabEmployeeManagementBinding(),
          children: [
            GetPage(
              name: _Paths.DESIGNATION_LAB_EMPLOYEE_MANAGEMENT,
              page: () => DesignationLabEmployeeManagementView(),
              binding: DesignationLabEmployeeManagementBinding(),
            ),
            GetPage(
              name: _Paths.SPECIAL_SKILL_LAB_EMPLOYEE_MANAGEMENT,
              page: () => SpecialSkillLabEmployeeManagementView(),
              binding: SpecialSkillLabEmployeeManagementBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.ELECTRICAL_EMPLOYEE_MANAGEMENT,
          page: () => ElectricalEmployeeManagementView(),
          binding: ElectricalEmployeeManagementBinding(),
        ),
        GetPage(
          name: _Paths.GAS_EMPLOYEE_MANAGEMENT,
          page: () => GasEmployeeManagementView(),
          binding: GasEmployeeManagementBinding(),
        ),
        GetPage(
          name: _Paths.IT_EMPLOYEE_MANAGEMENT,
          page: () => ItEmployeeManagementView(),
          binding: ItEmployeeManagementBinding(),
        ),
        GetPage(
          name: _Paths.BRANCH_DATA,
          page: () => BranchDataView(),
          binding: BranchDataBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MLGD_DATA_MONITORING,
      page: () => MlgdDataMonitoringView(),
      binding: MlgdDataMonitoringBinding(),
      children: [
        GetPage(
          name: _Paths.VIEW_MLGD_DATA_DATE_WISE,
          page: () => ViewMlgdDataDateWiseView(),
          binding: ViewMlgdDataDateWiseBinding(),
        ),
        GetPage(
          name: _Paths.VIEW_MLGD_DATA_RUN_WISE,
          page: () => ViewMlgdDataRunWiseView(),
          binding: ViewMlgdDataRunWiseBinding(),
        ),
        GetPage(
          name: _Paths.RUN_NO_DATA,
          page: () =>  RunNoDataView(),
          binding: RunNoDataBinding(),
        ),
        GetPage(
          name: _Paths.MLGD_BOTTOM_NAVIGATION,
          page: () => const MlgdBottomNavigationView(),
          binding: MlgdBottomNavigationBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.GAS_BANK_OPERATOR,
      page: () => GasBankOperatorView(),
      binding: GasBankOperatorBinding(),
      children: [
        GetPage(
          name: _Paths.GAS_MONITOR,
          page: () => GasMonitorView(),
          binding: GasMonitorBinding(),
        ),
        GetPage(
          name: _Paths.GASES,
          page: () => GasesView(),
          binding: GasesBinding(),
        ),
        GetPage(
          name: _Paths.GAS_MANIFOLD,
          page: () => GasManifoldView(),
          binding: GasManifoldBinding(),
        ),
        GetPage(
          name: _Paths.GAS_VENDOR,
          page: () => GasVendorView(),
          binding: GasVendorBinding(),
        ),
        GetPage(
          name: _Paths.SEARCH_BY_SERIAL_NO,
          page: () => SearchBySerialNoView(),
          binding: SearchBySerialNoBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.UPS_READING,
      page: () => UpsReadingView(),
      binding: UpsReadingBinding(),
      children: [
        GetPage(
          name: _Paths.UPS_DATA,
          page: () => UpsDataView(),
          binding: UpsDataBinding(),
        ),
        GetPage(
          name: _Paths.VIEW_UPS_READING,
          page: () => ViewUpsReadingDateWiseView(),
          binding: ViewUpsReadingBinding(),
        ),
        GetPage(
          name: _Paths.VIEW_UPS_READING_BRANCH_WISE,
          page: () => ViewUpsReadingBranchWiseView(),
          binding: ViewUpsReadingBranchWiseBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHILLER_READING,
      page: () => ChillerReadingView(),
      binding: ChillerReadingBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA_APPLICATION,
      page: () => CameraApplicationView(),
      binding: CameraApplicationBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
