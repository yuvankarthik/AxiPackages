<<
INSERT INTO axpages (name,caption,props,blobno,img,visible,type,parent,ordno,levelno,updatedon,createdon,importedon,createdby,updatedby,importedby,readonly,updusername,category,pagetype,intview,webenable,shortcut,icon,websubtype,workflow,oldappurl) VALUES ('HP1784290396716','PayrollDashboard','htmlPages.aspx?load=1784290396716',1,NULL,'T','p',NULL,(SELECT COALESCE(MAX(ordno),0) + 1 FROM axpages),0,'17/07/2026 17:48:22','17/07/2026 5:37:56 PM',NULL,'admin','admin',NULL,NULL,NULL,NULL,'web',NULL,NULL,NULL,NULL,'htmlpage',NULL,NULL)
>>

<<
insert
 into
 axpstructconfig (axpstructconfigid,
 cancel,
 sourceid,
 mapname,
 username,
 modifiedon,
 createdby,
 createdon,
 wkid,
 app_level,
 app_desc,
 app_slevel,
 cancelremarks,
 wfroles,
 asprops,
 setype,
 props,
 context,
 propvalue1,
 uploadfiletype,
 propvalue2,
 propsval,
 alluserroles,
 structcaption,
 structname,
 structelements,
 structelements1,
 sfield,
 icolumn,
 sbutton,
 hlink,
 stype,
 userroles,
 dupchk,
 purpose)
values(1012880000000,
'F',
0,
null,
'admin',
'2026-07-23 16:06:59.000',
'admin',
'2026-07-23 16:06:59.000',
null,
1,
1,
null,
null,
null,
'Landing Structure',
'All',
'General',
null,
'html pages',
null,
null,
'html pages',
'F',
'Inbox(HP1784802774665)',
'HP1784802774665',
null,
null,
null,
null,
null,
null,
'html pages',
'ALL',
'Landing StructureHP1784802774665GeneralALL',
null)
>>

<<
INSERT INTO axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd, pagination, applydimensions)
VALUES(2201990000000, 'F', 0, NULL, 'ashokk', '2026-06-18 21:17:12.000', 'ashokk', '2026-06-02 16:50:26.000', NULL, 1, 1, NULL, NULL, NULL, 'Pending Purchase Order Data', NULL, 'For users', 3, 'SELECT br.branchname,d.party_name as party_name,a.docdate,a.docid, concat(i.categoryname,'' - '', p.productcategory,'' - '' ,m.brand_name) as category,
c.itemdesc, c.uom, b.qty, b.shortcloseqty, b.receivedqty, 
       (b.qty - b.receivedqty - b.shortcloseqty) as pending_qty,b.netamount po_value,
       round(((b.qty - b.receivedqty - b.shortcloseqty)*b.netamount)/b.qty,2) pending_value 
  FROM po_header a, po_items b, item c, mg_supplier d, currency e, branch br,itemcategory i, productcategory p, brand_master m
  WHERE a.cancel = ''F''
    AND a.po_headerid = b.po_headerid
    AND (b.qty - b.receivedqty - b.shortcloseqty) > 0  
    AND b.itemname = c.itemid
    AND a.supplier = d.mg_supplierid
    and br.branchid = a.branch
    and c.itemcategory = i.itemcategoryid
      and c.productcategory = p.productcategoryid
      and c.itembrand = m.brand_masterid
   AND a.company = cast( :m_companyid as numeric)
  ORDER BY cast(a.docdate as date) desc', 'm_companyid', 'm_companyid~Numeric~', 'ALL', NULL, 'branchname,party_name,docdate,docid,category,itemdesc,uom,qty,shortcloseqty,receivedqty,pending_qty,po_value,pending_value', 'T', '1 Hr', NULL, 'Pending Purchase Order Data', NULL, 'T', 'F')
>>

<<
INSERT INTO axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd, pagination, applydimensions)
VALUES(2286661000000, 'F', 0, NULL, 'ashokk', '2026-06-02 15:31:46.000', 'ashokk', '2026-06-02 15:31:46.000', NULL, 1, 1, NULL, NULL, NULL, 'Purchase Summary', NULL, 'For users', 3, 'select a.docdate,s.statejurisdiction state, s.party_name,ic.categoryname,isb.productcategory,br.brand_name,  i.itemdesc,
sum(b.qty) po_qty,sum(grn.grn_qty) recivedqty,sum(returnqty) returnedqty,sum(grn.amount) amount,sum(grn.tax_amount) tax_amount,sum(grn.disc_amount) disc_amount,
sum(grn.bill_value) net_amount,to_char(a.docdate,''Mon'') mnth,to_char(a.docdate,''YYYY'') yr,
concat(''Q'',EXTRACT(QUARTER FROM  a.docdate)) qtr
from po_header a
join po_items b on a.po_headerid  = b.po_headerid 
join item i on b.itemname  = i.itemid 
join itemcategory ic on ic.itemcategoryid = i.itemcategory 
join productcategory isb on i.productcategory  = isb.productcategoryid 
join brand_master br on i.itembrand  = br.brand_masterid 
join mg_supplier s on a.supplier  = s.mg_supplierid 
left outer join (select b.po_itemsid,sum(b.qty ) grn_qty,sum(pb.bill_qty) bill_qty,sum(pb.net_amount) bill_value,sum(pb.amount) amount,sum(pb.tax) tax_amount,sum(pb.discount) disc_amount,
sum(pr.returnqty) returnqty,sum(pr.returned_value) returned_value
from grn_header a join grn_items b on a.grn_headerid  = b.grn_headerid 
left outer join (select b.grn_itemsid,sum(b.qty ) bill_qty,sum(b.grossamount) amount,sum(b.taxableamount ) tax,sum(b.discamount ) discount,
sum(b.netamount) net_amount from 
purchase_bill_header a
join Purchase_bill_items b on a.purchase_bill_headerid  = b.purchase_bill_headerid 
where a.cancel  = ''F'' and a.company  = cast( :m_companyid as numeric) group by grn_itemsid ) pb on b.grn_itemsid = pb.grn_itemsid
left outer join (select b.grn_itemsid ,sum(b.returnqty) returnqty, sum(b.netamount) returned_value
from purchasereturn_header a
join purchasereturn_items b on a.purchasereturn_headerid  = b.purchasereturn_headerid 
where a.cancel  = ''F''  and a.company  = cast( :m_companyid as numeric)
group by b.grn_itemsid ) pr on b.grn_itemsid = pb.grn_itemsid
where a.cancel  = ''F'' and a.company  = cast( :m_companyid as numeric) group by b.po_itemsid  ) grn on  b.po_itemsid = grn.po_itemsid
where a.cancel  = ''F''
and a.company  = cast( :m_companyid as numeric)
group by a.docdate,to_char(a.docdate,''MON-YY'') ,s.statejurisdiction , s.party_name,ic.categoryname,isb.productcategory,br.brand_name, i.itemdesc,
to_char(a.docdate,''Mon'') ,to_char(a.docdate,''YYYY'') ,
concat(''Q'',EXTRACT(QUARTER FROM  a.docdate)) 
order by s.party_name,a.docdate', 'm_companyid', 'm_companyid~Numeric~', 'ALL', NULL, 'docdate,state,party_name,categoryname,productcategory,brand_name,itemdesc,po_qty,recivedqty,returnedqty,amount,tax_amount,disc_amount,net_amount,mnth,yr,qtr', 'T', '1 Hr', NULL, 'Purchase Summary Data', NULL, 'T', 'F')
>>