class URLs {
  // static const baseUrl = 'https://server-ip.com/api';

  // Authentication
  static const login = 'authenticate';
  static const refresh = 'refresh';

  // Lookup
  static const getUserInfo = 'fndUser/getUserDetails';
  static const getBranchInfo = 'fndBranch/getCurrentBranch';
  static const branchLookup = 'fndBranch/getBranches';
  static const getItemInfo = 'master/getMasterPRInfo';
  static const getItemBasedUom = 'invUoM/getUom';
  static const getUomInfo = 'uom/uomByCriteria';
  static const usersLookup = 'fndUser/getUsers';
  static const requisitionStatusListLookup = 'tempPR/getTempPRStatusList';
  static const vendorLookup = 'vendor/getVendor';
  static const vendorBranchLookup = 'vendor/getVendorSite';
  static const poNumberFilterLookup = 'po/getPOHeaders';
  static const poNumberLookup = 'poReceipt/getSelectPo';
  static const toleranceCodeLookup = 'tolerance/getToleranceCodes';
  static const poLineNumberLookup = 'poReceipt/getPOLines';

  // Temp Requisition Header CRUD
  static const crudTempRequisitionHeaderAndLine = 'tempPR/tempPRInsertOrUpdateOrDelete';
  static const crudRequisitionLine = 'tempPR/tempPRLineInsertOrUpdateOrDelete';
  static const getRequisitions = 'tempPR/getTempRequistionHeader';
  static const deleteTempRequisition = 'tempPR/deleteTempRequistion';

  //Temp Line
  static const getRequisitionLines = 'tempPR/getTempRequistionLine';

  static const submitTempRequisition = 'tempPR/submitTempRequistion';

  static const saveRequisitionLine = 'tempPR/tempPRInsertOrUpdateOrDelete';

  // PO Receipt
  static const createOrUpdatePOReceiptHeaderUrl = 'poReceipt/insertOrUpdatePoReceipt';
  static const getPOReceipts = 'poReceipt/getPoReceiptHeader';
  static const getPOReceiptLines = 'poReceipt/getPoReceiptLine';
  static const submitPOReceipt = 'poReceipt/completePoReceipt';
  // PO Receipt Line
  static const createOrUpdatePOReceiptLine = 'poReceipt/insertOrUpdatePoReceiptLine';

}