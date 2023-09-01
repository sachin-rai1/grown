import 'package:get/get.dart';

import '../modules/SplashScreen/bindings/splash_screen_binding.dart';
import '../modules/SplashScreen/views/splash_screen_view.dart';
import '../modules/bcdi_classification/bindings/bcdi_classification_binding.dart';
import '../modules/bcdi_classification/views/bcdi_classification_view.dart';
import '../modules/bcdi_detection/bindings/bcdi_detection_binding.dart';
import '../modules/bcdi_detection/views/bcdi_detection_view.dart';
import '../modules/bcdi_multi_label/bindings/bcdi_multi_label_binding.dart';
import '../modules/bcdi_multi_label/views/bcdi_multi_label_view.dart';
import '../modules/chiller_reading/bindings/chiller_reading_binding.dart';
import '../modules/chiller_reading/branchwise_chiller_reading/bindings/branchwise_chiller_reading_binding.dart';
import '../modules/chiller_reading/branchwise_chiller_reading/views/branchwise_chiller_reading_view.dart';
import '../modules/chiller_reading/chiller_compressor/bindings/chiller_compressor_binding.dart';
import '../modules/chiller_reading/chiller_compressor/views/chiller_compressor_view.dart';
import '../modules/chiller_reading/chiller_phase/bindings/chiller_phase_binding.dart';
import '../modules/chiller_reading/chiller_phase/views/chiller_phase_view.dart';
import '../modules/chiller_reading/chillers/bindings/chillers_binding.dart';
import '../modules/chiller_reading/chillers/views/chillers_view.dart';
import '../modules/chiller_reading/datewise_chiller_reading/bindings/datewise_chiller_reading_binding.dart';
import '../modules/chiller_reading/datewise_chiller_reading/views/datewise_chiller_reading_view.dart';
import '../modules/chiller_reading/process_pump/bindings/process_pump_binding.dart';
import '../modules/chiller_reading/process_pump/views/process_pump_view.dart';
import '../modules/chiller_reading/views/chiller_reading_view.dart';
import '../modules/email_config/bindings/email_config_binding.dart';
import '../modules/email_config/views/email_config_view.dart';
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
import '../modules/feedback/bindings/feedback_binding.dart';
import '../modules/feedback/views/feedback_view.dart';
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
import '../modules/maintenance/assign_engineer/bindings/assign_engineer_binding.dart';
import '../modules/maintenance/assign_engineer/views/assign_engineer_view.dart';
import '../modules/maintenance/bindings/maintenance_binding.dart';
import '../modules/maintenance/edit_assigned_engineer/bindings/edit_assigned_engineer_binding.dart';
import '../modules/maintenance/edit_assigned_engineer/views/edit_assigned_engineer_view.dart';
import '../modules/maintenance/engineer/bindings/engineer_binding.dart';
import '../modules/maintenance/engineer/views/engineer_view.dart';
import '../modules/maintenance/register_complain/bindings/register_complain_binding.dart';
import '../modules/maintenance/register_complain/views/register_complain_view.dart';
import '../modules/maintenance/view_complain/bindings/view_complain_binding.dart';
import '../modules/maintenance/view_complain/branch_wise_complain/bindings/branch_wise_complain_binding.dart';
import '../modules/maintenance/view_complain/branch_wise_complain/views/branch_wise_complain_view.dart';
import '../modules/maintenance/view_complain/date_wise_complain/bindings/date_wise_complain_binding.dart';
import '../modules/maintenance/view_complain/date_wise_complain/views/date_wise_complain_view.dart';
import '../modules/maintenance/view_complain/views/view_complain_view.dart';
import '../modules/maintenance/views/maintenance_view.dart';
import '../modules/mlgd_data_monitoring/MlgdBottomNavigation/bindings/mlgd_bottom_navigation_binding.dart';
import '../modules/mlgd_data_monitoring/MlgdBottomNavigation/views/mlgd_bottom_navigation_view.dart';
import '../modules/mlgd_data_monitoring/RunNoData/bindings/run_no_data_binding.dart';
import '../modules/mlgd_data_monitoring/RunNoData/views/run_no_data_view.dart';
import '../modules/mlgd_data_monitoring/bindings/mlgd_data_monitoring_binding.dart';
import '../modules/mlgd_data_monitoring/post_run/bindings/post_run_binding.dart';
import '../modules/mlgd_data_monitoring/post_run/date_wise_post_run_data/bindings/date_wise_post_run_data_binding.dart';
import '../modules/mlgd_data_monitoring/post_run/date_wise_post_run_data/views/date_wise_post_run_data_view.dart';
import '../modules/mlgd_data_monitoring/post_run/run_no_wise_post_run_data/bindings/view_post_run_data_binding.dart';
import '../modules/mlgd_data_monitoring/post_run/run_no_wise_post_run_data/views/view_post_run_data_view.dart';
import '../modules/mlgd_data_monitoring/post_run/views/post_run_view.dart';
import '../modules/mlgd_data_monitoring/pre_run/bindings/pre_run_binding.dart';
import '../modules/mlgd_data_monitoring/pre_run/camera_screen/bindings/camera_screen_binding.dart';
import '../modules/mlgd_data_monitoring/pre_run/camera_screen/views/camera_screen_view.dart';
import '../modules/mlgd_data_monitoring/pre_run/date_wise_pre_run_data/bindings/date_wise_pre_run_data_binding.dart';
import '../modules/mlgd_data_monitoring/pre_run/date_wise_pre_run_data/views/date_wise_pre_run_data_view.dart';
import '../modules/mlgd_data_monitoring/pre_run/gallery_screen/bindings/gallery_screen_binding.dart';
import '../modules/mlgd_data_monitoring/pre_run/gallery_screen/views/gallery_screen_view.dart';
import '../modules/mlgd_data_monitoring/pre_run/pre_run_view_data/bindings/pre_run_view_data_binding.dart';
import '../modules/mlgd_data_monitoring/pre_run/pre_run_view_data/views/pre_run_view_data_view.dart';
import '../modules/mlgd_data_monitoring/pre_run/preview_screen/bindings/preview_screen_binding.dart';
import '../modules/mlgd_data_monitoring/pre_run/preview_screen/views/preview_screen_view.dart';
import '../modules/mlgd_data_monitoring/pre_run/views/pre_run_view.dart';
import '../modules/mlgd_data_monitoring/running_data/bindings/growing_binding.dart';
import '../modules/mlgd_data_monitoring/running_data/view_running_data_date_wise/bindings/view_mlgd_data_date_wise_binding.dart';
import '../modules/mlgd_data_monitoring/running_data/view_running_data_date_wise/views/view_mlgd_data_date_wise_view.dart';
import '../modules/mlgd_data_monitoring/running_data/view_running_data_run_wise/bindings/view_mlgd_data_run_wise_binding.dart';
import '../modules/mlgd_data_monitoring/running_data/view_running_data_run_wise/views/view_mlgd_data_run_wise_view.dart';
import '../modules/mlgd_data_monitoring/running_data/views/growing_view.dart';
import '../modules/mlgd_data_monitoring/views/mlgd_data_monitoring_view.dart';
import '../modules/pcc_reading/bindings/pcc_reading_binding.dart';
import '../modules/pcc_reading/branchwise_pcc_reading/bindings/branchwise_pcc_reading_binding.dart';
import '../modules/pcc_reading/branchwise_pcc_reading/views/branchwise_pcc_reading_view.dart';
import '../modules/pcc_reading/datewise_pcc_reading/bindings/datewise_pcc_reading_binding.dart';
import '../modules/pcc_reading/datewise_pcc_reading/views/datewise_pcc_reading_view.dart';
import '../modules/pcc_reading/insert_pcc_reading/bindings/insert_pcc_reading_binding.dart';
import '../modules/pcc_reading/insert_pcc_reading/views/insert_pcc_reading_view.dart';
import '../modules/pcc_reading/pcc_data/bindings/pcc_data_binding.dart';
import '../modules/pcc_reading/pcc_data/views/pcc_data_view.dart';
import '../modules/pcc_reading/views/pcc_reading_view.dart';
import '../modules/ups_reading/ViewUpsReadingBranchWise/bindings/view_ups_reading_branch_wise_binding.dart';
import '../modules/ups_reading/ViewUpsReadingBranchWise/views/view_ups_reading_branch_wise_view.dart';
import '../modules/ups_reading/ViewUpsReadingDateWise/bindings/view_ups_reading_binding.dart';
import '../modules/ups_reading/ViewUpsReadingDateWise/views/view_ups_reading_view.dart';
import '../modules/ups_reading/bindings/ups_reading_binding.dart';
import '../modules/ups_reading/upsData/bindings/ups_data_binding.dart';
import '../modules/ups_reading/upsData/views/ups_data_view.dart';
import '../modules/ups_reading/views/ups_reading_view.dart';
import '../modules/user_management/bindings/user_management_binding.dart';
import '../modules/user_management/views/user_management_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

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
          page: () => const ElectricalEmployeeManagementView(),
          binding: ElectricalEmployeeManagementBinding(),
        ),
        GetPage(
          name: _Paths.GAS_EMPLOYEE_MANAGEMENT,
          page: () => const GasEmployeeManagementView(),
          binding: GasEmployeeManagementBinding(),
        ),
        GetPage(
          name: _Paths.IT_EMPLOYEE_MANAGEMENT,
          page: () => const ItEmployeeManagementView(),
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
          page: () => RunNoDataView(),
          binding: RunNoDataBinding(),
        ),
        GetPage(
          name: _Paths.MLGD_BOTTOM_NAVIGATION,
          page: () => const MlgdBottomNavigationView(),
          binding: MlgdBottomNavigationBinding(),
        ),
        GetPage(
          name: _Paths.GROWING,
          page: () => GrowingView(),
          binding: GrowingBinding(),
        ),
        GetPage(
          name: _Paths.POST_RUN,
          page: () => PostRunView(),
          binding: PostRunBinding(),
          children: [
            GetPage(
              name: _Paths.DATE_WISE_POST_RUN_DATA,
              page: () => DateWisePostRunDataView(),
              binding: DateWisePostRunDataBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.PRE_RUN,
          page: () => PreRunView(),
          binding: PreRunBinding(),
          children: [
            GetPage(
              name: _Paths.PRE_RUN_VIEW_DATA,
              page: () => PreRunViewDataView(),
              binding: PreRunViewDataBinding(),
            ),
            GetPage(
              name: _Paths.DATE_WISE_PRE_RUN_DATA,
              page: () => DateWisePreRunDataView(),
              binding: DateWisePreRunDataBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.CAMERA_SCREEN,
          page: () => CameraScreenView(),
          binding: CameraScreenBinding(),
        ),
        GetPage(
          name: _Paths.GALLERY_SCREEN,
          page: () => const GalleryScreenView(),
          binding: GalleryScreenBinding(),
        ),
        GetPage(
          name: _Paths.PREVIEW_SCREEN,
          page: () => PreviewScreenView(),
          binding: PreviewScreenBinding(),
        ),
        GetPage(
          name: _Paths.VIEW_POST_RUN_DATA,
          page: () => ViewPostRunDataView(),
          binding: ViewPostRunDataBinding(),
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
      children: [
        GetPage(
          name: _Paths.CHILLER_PHASE,
          page: () => ChillerPhaseView(),
          binding: ChillerPhaseBinding(),
        ),
        GetPage(
          name: _Paths.CHILLER_COMPRESSOR,
          page: () => ChillerCompressorView(),
          binding: ChillerCompressorBinding(),
        ),
        GetPage(
          name: _Paths.CHILLERS,
          page: () => ChillersView(),
          binding: ChillersBinding(),
        ),
        GetPage(
          name: _Paths.DATEWISE_CHILLER_READING,
          page: () => DateWiseChillerReadingView(),
          binding: DatewiseChillerReadingBinding(),
        ),
        GetPage(
          name: _Paths.BRANCHWISE_CHILLER_READING,
          page: () => BranchWiseChillerReadingView(),
          binding: BranchwiseChillerReadingBinding(),
        ),
        GetPage(
          name: _Paths.PROCESS_PUMP,
          page: () => ProcessPumpView(),
          binding: ProcessPumpBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: _Paths.USER_MANAGEMENT,
      page: () => const UserManagementView(),
      binding: UserManagementBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.MAINTENANCE,
      page: () => MaintenanceView(),
      binding: MaintenanceBinding(),
      children: [
        GetPage(
          name: _Paths.REGISTER_COMPLAIN,
          page: () => RegisterComplainView(),
          binding: RegisterComplainBinding(),
        ),
        GetPage(
          name: _Paths.VIEW_COMPLAIN,
          page: () => ViewComplainView(),
          binding: ViewComplainBinding(),
          children: [
            GetPage(
              name: _Paths.DATE_WISE_COMPLAIN,
              page: () => DateWiseComplainView(),
              binding: DateWiseComplainBinding(),
            ),
            GetPage(
              name: _Paths.BRANCH_WISE_COMPLAIN,
              page: () => BranchWiseComplainView(),
              binding: BranchWiseComplainBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.ASSIGN_ENGINEER,
          page: () => AssignEngineerView(),
          binding: AssignEngineerBinding(),
        ),
        GetPage(
          name: _Paths.ENGINEER,
          page: () => EngineerView(),
          binding: EngineerBinding(),
        ),
        GetPage(
          name: _Paths.EDIT_ASSIGNED_ENGINEER,
          page: () => EditAssignedEngineerView(),
          binding: EditAssignedEngineerBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.EMAIL_CONFIG,
      page: () => EmailConfigView(),
      binding: EmailConfigBinding(),
    ),
    GetPage(
      name: _Paths.PCC_READING,
      page: () => const PccReadingView(),
      binding: PccReadingBinding(),
      children: [
        GetPage(
          name: _Paths.INSERT_PCC_READING,
          page: () => InsertPccReadingView(),
          binding: InsertPccReadingBinding(),
        ),
        GetPage(
          name: _Paths.DATEWISE_PCC_READING,
          page: () => DatewisePccReadingView(),
          binding: DatewisePccReadingBinding(),
        ),
        GetPage(
          name: _Paths.BRANCHWISE_PCC_READING,
          page: () => BranchwisePccReadingView(),
          binding: BranchwisePccReadingBinding(),
        ),
        GetPage(
          name: _Paths.PCC_DATA,
          page: () => PccDataView(),
          binding: PccDataBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.BCDI_MULTI_LABEL,
      page: () => BcdiMultiLabelView(),
      binding: BcdiMultiLabelBinding(),
    ),
  ];
}
