--AP>송장>송장 조회 시 System > Last_Query

SELECT ROWID
     , ROW_ID
     , INVOICE_ID
     , INVOICE_DISTRIBUTION_ID
     , PREPAY_DISTRIBUTION_ID
     , PREPAY_DIST_NUMBER
     , PREPAY_AMOUNT_APPLIED
     , DIST_CODE_COMBINATION_ID
     , ACCOUNTING_DATE
     , PERIOD_NAME
     , SET_OF_BOOKS_ID
     , DESCRIPTION
     , PO_DISTRIBUTION_ID
     , RCV_TRANSACTION_ID
     , ORG_ID
     , INVOICE_NUM
     , VENDOR_ID
     , VENDOR_SITE_ID
     , TAX_ID
     , TAX_CODE
     , PO_NUMBER
     , VENDOR_NAME
     , VENDOR_NUMBER
     , VENDOR_SITE_CODE
     , RECEIPT_NUMBER
     , PREPAY_ID
  FROM AP_UNAPPLY_PREPAYS_FR_PREPAY_V
 WHERE (VENDOR_ID = 2264014)
   and (PREPAY_ID = 309026)
   
     
--create or replace view ap_unapply_prepays_fr_prepay_v as
select aid1.rowid row_id
     , aid1.invoice_id invoice_id
     , aid1.invoice_distribution_id invoice_distribution_id
     , aid1.prepay_distribution_id prepay_distribution_id
     , aid2.distribution_line_number prepay_dist_number
     , (-1) * aid1.amount prepay_amount_applied
     , aid1.dist_code_combination_id dist_code_combination_id
     , aid1.accounting_date accounting_date
     , aid1.period_name period_name
     , aid1.set_of_books_id set_of_books_id
     , aid1.description description
     , aid1.po_distribution_id po_distribution_id
     , aid1.rcv_transaction_id rcv_transaction_id
     , aid1.org_id org_id
     , ai.invoice_num invoice_num
     , ai.vendor_id vendor_id
     , ai.vendor_site_id vendor_site_id
     , atc.tax_id tax_id
     , atc.name tax_code
     , ph.segment1 po_number
     , pv.vendor_name vendor_name
     , pv.segment1 vendor_number
     , pvs.vendor_site_code vendor_site_code
     , rsh.receipt_num receipt_number
     , aid2.invoice_id prepay_id
  from ap_invoices              ai    -- view / ap>송장>송장 / table : ap_invoices_all
     --Standard Objects는 대부분 View로 이루어져 있다.
     --말이 대부분이지 전부인듯?
     , ap_invoice_distributions aid1
     , ap_invoice_distributions aid2
     , ap_tax_codes             atc
     , po_vendors               pv    -- table / AP>공급자>입력,지점?? / Vendors info table??
     , po_vendor_sites          pvs   -- view / AP>공급자>입력,지점?? / table : PO_VENDOR_SITES_ALL
     , po_distributions         pd 
     , po_headers               ph
     , po_lines                 pl
     , po_line_locations        pll
     , rcv_transactions         rtxns
     , rcv_shipment_headers     rsh
     , rcv_shipment_lines       rsl
 where aid1.prepay_distribution_id = aid2.invoice_distribution_id
   and ai.invoice_id = aid1.invoice_id
   and aid1.amount < 0
   and nvl(aid1.reversal_flag, 'N') != 'Y'
   and aid2.tax_code_id = atc.tax_id(+)
   and aid1.line_type_lookup_code = 'PREPAY'
   and ai.vendor_id = pv.vendor_id
   and ai.vendor_site_id = pvs.vendor_site_id
   and aid1.po_distribution_id = pd.po_distribution_id(+)
   and pd.po_header_id = ph.po_header_id(+)
   and pd.line_location_id = pll.line_location_id(+)
   and pll.po_line_id = pl.po_line_id(+)
   and aid1.rcv_transaction_id = rtxns.transaction_id(+)
   and rtxns.shipment_line_id = rsl.shipment_line_id(+)
   and rsl.shipment_header_id = rsh.shipment_header_id(+)
   and ai.invoice_type_lookup_code not in ('PREPAYMENT', 'CREDIT', 'DEBIT');

   
   
