import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/bloc/wizard_event.dart';
import 'package:etteo_demo/bloc/wizard_state.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/common.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/documents/documents_type_model.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/model/parts/parts_status_model.dart';
import 'package:etteo_demo/model/parts/parts_type_model.dart';
import 'package:etteo_demo/model/services/service_component_model.dart';
import 'package:etteo_demo/model/services/service_status_model.dart';
import 'package:etteo_demo/model/services/service_sub_status_model.dart';
import 'package:etteo_demo/model/services/service_type_model.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';
import 'package:etteo_demo/providers/orders_provider.dart';

class WizardBloc extends Bloc<WizardEvent, WizardState> {
  OfflineApi _offlineApi = OfflineApi();
  OrdersProvider _ordersProvider = OrdersProvider();

  bool closed = false;

  List<NotesModel> wizardEntryNotes = List();
  List<PartsModel> wizardEntryParts = List();
  List<ServicesModel> wizardEntryServices = List();
  List<DocumentsModel> wizardEntryDocuments = List();
  ServicesModel selectedService;
  ServicesModel cloneServiceModel;

  List<ServiceStatusModel> serviceStatusList = List();
  List<ServiceSubStatusModel> serviceSubStatusList = List();
  ServiceStatusModel selectedServiceStatus;
  ServiceSubStatusModel selectedServiceSubStatus;

  String selectedOrderId;
  OrderDetailModel selectedOrderDetail;

  /// Create new services
  List<ServiceComponentModel> serviceComponents = List();
  List<ServiceTypeModel> serviceTypes = List();

  ServiceComponentModel selectedServiceComponentGuid;
  ServiceTypeModel selectedServiceTypeGuid;

  ServiceStatusModel get statusForAuditRequired {
    List<ServiceStatusModel> sm = serviceStatusList
        .where((st) => st.serviceStatusName == "Audit Required")
        .toList();

    return sm != null && sm.length > 0 ? sm[0] : null;
  }

  ServiceStatusModel get statusForUnableToComplete {
    List<ServiceStatusModel> sm = serviceStatusList
        .where((st) => st.serviceStatusName == "Unable To Complete")
        .toList();

    return sm != null && sm.length > 0 ? sm[0] : null;
  }

  /// Create new parts
  List<PartsTypeModel> partsType = List();
  List<PartsStatusModel> partsStatus = List();

  PartsTypeModel selectedPartTypeModel;
  PartsStatusModel selectedPartStatusModel;

  PartsStatusModel get defaultPartStatusRequested {
    List<PartsStatusModel> ps = partsStatus
        .where((st) => st.unitStatusDescription == "REQUESTED")
        .toList();

    return ps != null && ps.length > 0 ? ps[0] : null;
  }

  PartsStatusModel get defaultPartStatusOnLocation {
    List<PartsStatusModel> ps = partsStatus
        .where((st) => st.unitStatusDescription == "ON LOCATION")
        .toList();

    return ps != null && ps.length > 0 ? ps[0] : null;
  }

  PartsTypeModel get defaultPartTypeSupplied {
    List<PartsTypeModel> ps =
        partsType.where((st) => st.unitTypeDescription == "SUPPLIED").toList();

    return ps != null && ps.length > 0 ? ps[0] : null;
  }

  PartsTypeModel get defaultPartTypeCurrentUnit {
    List<PartsTypeModel> ps = partsType
        .where((st) => st.unitTypeDescription == "CURRENT UNIT")
        .toList();

    return ps != null && ps.length > 0 ? ps[0] : null;
  }

  PartsTypeModel get defaultPartTypeRequested {
    List<PartsTypeModel> ps =
        partsType.where((st) => st.unitTypeDescription == "REQUESTED").toList();

    return ps != null && ps.length > 0 ? ps[0] : null;
  }

  /// Create Document
  List<DocumentsTypeModel> documentTypes = List();

  DocumentsTypeModel get defaultDocumentTypeCurrentUnit {
    List<DocumentsTypeModel> dt =
        documentTypes.where((d) => d.documentTypeName == "Unit Photo").toList();

    return dt != null && dt.length > 0 ? dt[0] : null;
  }

  DocumentsTypeModel get defaultDocumentTypeDataPlate {
    List<DocumentsTypeModel> dt =
        documentTypes.where((d) => d.documentTypeName == "Data Plate").toList();

    return dt != null && dt.length > 0 ? dt[0] : null;
  }

  // PartsModel partsModelInMemory;

  _addNotesModel(String noteData) {
    String noteDate = DateTime.now().toUtc().toString();

    NotesModel newNote = NotesModel.fromJson({
      'createdBy': AppConfig().userProfile.fullName,
      'noteData': noteData + '--' + noteDate,
      'createdDate': noteDate
    });
    wizardEntryNotes.add(newNote);
  }

  _addServiceModel(ServicesModel service) {
    wizardEntryServices.add(service);
    selectedServiceTypeGuid = null;
    selectedServiceComponentGuid = null;
  }

  _addPartsModel(PartsModel part) {
    wizardEntryParts.add(part);
    selectedPartTypeModel = null;
    selectedPartStatusModel = null;
  }

  _addDocumentsModel(DocumentsModel document) {
    wizardEntryDocuments.add(document);
  }

  _addMultipleDocumentsModel(List<DocumentsModel> documents) {
    wizardEntryDocuments.addAll(documents);
  }

  @override
  WizardState get initialState => InitialWizardState();

  @override
  Stream<WizardState> mapEventToState(
    WizardEvent event,
  ) async* {
    if (event is InitialWizardEvent) {
      cloneServiceModel = ServicesModel.fromJson(selectedService?.toJson());
    }
    if (event is AddWizardNote) {
      _addNotesModel(event.noteData);
    }

    if (event is AddWizardService) {
      _addServiceModel(event.service);
    }

    if (event is AddWizardPart) {
      _addPartsModel(event.part);
    }

    if (event is AddWizardDocument) {
      _addDocumentsModel(event.document);
    }

    if (event is AddWizardMultipleDocument) {
      _addMultipleDocumentsModel(event.documents);
    }

    if (event is WizardComplete) {
      yield WizardCompleting();
      yield WizardProgress(message: 'processing...');
      print('Wizard complete');
      print(wizardEntryNotes);
      print(wizardEntryParts);
      print(wizardEntryServices);
      print(wizardEntryDocuments);

      int noteLength = wizardEntryNotes.length;
      int partLength = wizardEntryParts.length;
      int serviceLength = wizardEntryServices.length;
      int documentLength = wizardEntryDocuments.length;

      await delay();
      yield WizardProgress(message: 'updating service status...');

      await _offlineApi.createService(
          orderId: selectedOrderDetail.orderId,
          service: selectedService,
          update: true);

      await delay();
      // yield WizardProgress(message: 'creating notes...');

      for (int i = 0, j = 1; i < noteLength; i++, j++) {
        NotesModel note = wizardEntryNotes[i];
        yield WizardProgress(message: 'creating note ($j/$noteLength)');

        await _offlineApi.createNote(selectedOrderDetail.orderId, note);
        selectedOrderDetail.addNoteList(List.filled(1, note));
        await delay();
      }

      await delay();
      yield WizardProgress(message: 'creating services...');

      for (int i = 0, j = 1; i < serviceLength; i++, j++) {
        ServicesModel service = wizardEntryServices[i];
        yield WizardProgress(message: 'creating service ($j/$serviceLength)');
        await _offlineApi.createService(
            orderId: selectedOrderDetail.orderId, service: service);
        selectedOrderDetail.addServiceList(service);
        await delay();
      }

      await delay();
      yield WizardProgress(message: 'creating parts...');

      for (int i = 0, j = 1; i < partLength; i++, j++) {
        PartsModel part = wizardEntryParts[i];
        yield WizardProgress(message: 'creating part ($j/$partLength)');
        await _offlineApi.createPart(selectedOrderDetail.orderId, part);
        selectedOrderDetail.addPartsList(part);
        await delay();
      }

      await delay();
      yield WizardProgress(message: 'creating documents...');

      for (int i = 0, j = 1; i < documentLength; i++, j++) {
        DocumentsModel document = wizardEntryDocuments[i];
        yield WizardProgress(message: 'creating document ($j/$documentLength)');
        await _offlineApi.createDocument(selectedOrderDetail.orderId, document);
        selectedOrderDetail.addDocument(document);
        await delay();
      }

      print("From all invocation to sync");
      print('SYNC Online COMPLETE');
      print('Wizard Online complete');
      yield WizardProgress(message: 'completed');
      await delay();

      await _ordersProvider.updateOrderToOfflineStorage(
          selectedOrderDetail, selectedOrderDetail.orderId);

      // Trigger sync with portal immediately.
      if (AppConfig().isOnline) {
        Future(() => {SyncQueue().checkSyncQueue()});
      }

      yield WizardProgressDone();
    }

    if (event is SetProgress) {
      yield WizardProgress(
          message: event.message, percentage: event.percentage);
    }

    if (event is FetchWizardDropdownValues) {
      selectedServiceSubStatus = null;
      var serviceStatusListTemp =
          await _offlineApi.getAllServiceStatusAndItsSubStatus();
      serviceStatusList =
          serviceStatusListTemp.where((ss) => ss.isDelegate == true).toList();

      serviceStatusList.forEach((ssl) => {
            if (ssl.serviceStatusName == "Unable To Complete" && ssl.isDelegate)
              {
                selectedServiceStatus = ssl,
                // ssl.serviceSubStatuses.forEach((sst) => {
                //       if (sst.isDelegate) {serviceSubStatusList.add(sst)}
                //     })
                serviceSubStatusList = ssl.serviceSubStatuses
                    .where((st) => st.isDelegate == true)
                    .toList()
              }
          });

      // Loading dropdown for new service
      selectedServiceComponentGuid = null;
      selectedServiceTypeGuid = null;
      serviceComponents = await _offlineApi.getAllServiceComponent(
          selectedOrderDetail.order.lineOfBusiness.lineOfBusinessGuid);

      serviceTypes = await _offlineApi.getAllServiceType(
          selectedOrderDetail.order.lineOfBusiness.lineOfBusinessGuid);

      selectedPartStatusModel = null;
      selectedPartTypeModel = null;

      partsType = await _offlineApi.getAllPartsType();
      partsStatus = await _offlineApi.getAllPartsStatus();

      documentTypes = await _offlineApi.getAllDocumentTypeforServiceProvider(
          selectedOrderDetail.order.owner.ownerId);

      yield WizardDropdownValuesFetched();
    }

    if (event is CloseWizard) {
      selectedService = cloneServiceModel;
      closed = true;
    }
  }
}
