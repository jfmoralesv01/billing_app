
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View of Billing Doc Header'
@Metadata.allowExtensions: true
define root view entity zsac_c_billheader_j
  provider contract transactional_query
  as projection on ZSAC_I_BILL_HEADER_j
{
  key BillId,
      BillType,
      BillDate,
      CustomerId,
      @Semantics.amount.currencyCode: 'Currency'
      NetAmount,
      Currency,
      SalesOrg,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangeDat,
      LocalLastChangeDat,
      
      _item: redirected to composition child ZSAC_C_Bill_Item_j
}
