@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View of Billing Doc Item'
@Metadata.allowExtensions: true
define view entity ZSAC_C_Bill_Item_j
  as projection on ZSAC_I_BILL_ITEM_j
{
  key BillId,
  key ItemNo,
      MaterialId,
      description,
      quantity,
      ItemAmount,
      currency,
      uom,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      /* Associations */
      _header : redirected to parent zsac_c_billheader_j
}
