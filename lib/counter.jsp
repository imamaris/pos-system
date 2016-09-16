<script language="javascript">

/*============================================================================
 *  Order Form Validation
 ===========================================================================*/

/** variables **/

var orderPayment = 0;

ProductList = new Array();
PaymodeList = new Array();

/** class **/

function Product(id, price, bv, ct) {
	this.id = id;
	this.price = price;
	this.bv = bv;
	this.ct = ct;
}
			
function addProduct(id, price, bv, ct) {
	ProductList[ProductList.length] = new Product(id, price, bv, ct);
}

function Paymode(id) {
	this.id = id;
}
			
function addPaymode(id) {
	PaymodeList[PaymodeList.length] = new Paymode(id);
}

/** functions **/

function init() {
	var thisform = document.frmSalesOrder;

        rate = eval("thisform.irate").value;
        ulang2 = eval("thisform.ulangi").value;
        
        qty = eval("thisform.Qty_" + i ).value;
        foc = eval("thisform.Foc_" + i ).value;
        disc = eval("thisform.Disc_" + i ).value;
	price = eval("thisform.iprice_" + i ).value;   
        
        
	for (var i=1; i < 8 ; i++) {
		
		// qty = eval("thisform.Qty_" + i).value;                
                qty = eval("thisform.Qty_" + i ).value;
                foc = eval("thisform.Foc_" + i ).value;
                price = eval("thisform.iprice_" + i ).value;  		
                
                if (qty > 0) {
			var total = eval("Amt_"+ i);
			// total.innerText = qty==0?"":decFormat(ProductList[i].price * qty);
                        total.innerText = qty==0?"":formatAmount((price * rate * qty) - foc);  // decFormat(ProductList[idx].price * unit);
                        total.value = qty==0?"":formatAmount((price * rate * qty) - foc);  // decFormat(ProductList[idx].price * unit);    
                }
	}
        
        
        

	calcGrandTotal();
}


function CalcQty(i, obj) {

       var unit = obj.value;
        
	if (isNaN(unit)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		obj.value = "";
		obj.focus();
		return;
	}
        
        
	// var total = eval("Amt_1.id");        
	// total.innerText = unit==0?"":formatAmount((price_1 * unit ));  
        
        // decFormat(ProductList[idx].price * unit);
	
	obj.value = unit == 0 ? "" : (unit * 1);
	
	// calcGrandTotal();
}


function ValidNumber() {
	// var unit = obj.value;
	var thisform = document.frmSalesOrder;
        
        customer = eval("thisform.CustomerContact").value;
        
	if (isNaN(customer)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		customer.value = "";
		customer.focus();
		return;
	}

        customer.value = customer == 0 ? "" : (customer * 1);
}

function calcUnitAsal(idx, obj) {
	var unit = obj.value;
        
	if (isNaN(unit)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		obj.value = "";
		obj.focus();
		return;
	}
        
	var total = eval("Amt_"+ProductList[idx].ct+"_"+ProductList[idx].id);
	total.innerText = unit==0?"":formatAmount((ProductList[idx].price * unit));  // decFormat(ProductList[idx].price * unit);
	
	obj.value = unit == 0 ? "" : (unit * 1);
	
	calcGrandTotal();
}

function calcUnit(i, obj) {
	var unit = obj.value;
	var thisform = document.frmSalesOrder;
        
	if (isNaN(unit)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		obj.value = "";
		obj.focus();
		return;
	}
           
        var total = eval("Amt_"+i);        
                       
	rate = eval("thisform.irate").value;
        ulang2 = eval("thisform.ulangi").value;
        
        qty = eval("thisform.Qty_" + i ).value;
        foc = eval("thisform.Foc_" + i ).value;
	price = eval("thisform.iprice_" + i ).value;                
        
        var total = eval("thisform.Amt_"+i); 
	total.innerText = total == 0 ? ""  :formatAmount((price * rate * qty) - foc);  // decFormat(ProductList[idx].price * unit);
        total.value = total == 0 ? ""  :formatAmount((price * rate * qty) - foc);  // decFormat(ProductList[idx].price * unit);
        
        sales1 = eval("thisform.isales").value;
        var sales2 = eval("thisform.isales_"+i);        
        sales2.value = sales2 == 0 ? "0.00"  : sales1;
        
        obj.value = unit == 0 ? "" : (unit * 1);
	
	calcGrandTotal();
}

function calcUnitFoc(i, obj) {
	var unit = obj.value;
	var thisform = document.frmSalesOrder;
        
	if (isNaN(unit)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		obj.value = "";
		obj.focus();
		return;
	}else
        {
        // jika ok, kursor langsung ke isales
        var sales2 = eval("thisform.isales_"+i);   
        sales2.focus();
        }
        
           
        var total = eval("Amt_"+i);                        
                
	rate = eval("thisform.irate").value;
        ulang2 = eval("thisform.ulangi").value;
        
        qty = eval("thisform.Qty_" + i ).value;
        foc = eval("thisform.Foc_" + i ).value;
	price = eval("thisform.iprice_" + i ).value;                
                
	var total = eval("thisform.Amt_"+i); 
        total.value = total == 0 ? ""  :formatAmount((price * rate * qty) - foc);  // decFormat(ProductList[idx].price * unit);
        total.innerText = total == 0 ? ""  :formatAmount((price * rate * qty) - foc);  // decFormat(ProductList[idx].price * unit);
        
        var disc = eval("thisform.Disc_"+i);        
        disc.value = disc == 0 ? "0.00"  : decFormat( ( foc/(price * rate * qty) ) * 100 );
        
        /* pindah ke Qty
        sales1 = eval("thisform.isales").value;
        var sales2 = eval("thisform.isales_"+i);        
        sales2.value = sales2 == 0 ? "0.00"  : sales1;
        */        
        obj.value = unit == 0 ? "" : (unit * 1);
	
        
	calcGrandTotal();


}

function calcUnitFoc2(i, obj) {
	var unit = obj.value;
	var thisform = document.frmSalesOrder;
        
	if (isNaN(unit)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		obj.value = "";
		obj.focus();
		return;
	}
           
        
        
	rate = eval("thisform.irate").value;
        ulang2 = eval("thisform.ulangi").value;
        
        qty = eval("thisform.Qty_" + i ).value;        
        disc = eval("thisform.Disc_" + i ).value;
	price = eval("thisform.iprice_" + i ).value;     

        var foc = eval("thisform.Foc_"+i);        
        foc.value = foc == 0 ? "0.00"  : decFormat( ( disc * (price * rate * qty) ) / 100 );        
        
        foc2 = eval("thisform.Foc_" + i ).value;
        
        var total = eval("thisform.Amt_"+i);      
        total.value = total == 0 ? ""  :formatAmount((price * rate * qty) - foc2);  // decFormat(ProductList[idx].price * unit);
        
        total.innerText = total == 0 ? ""  :formatAmount((price * rate * qty) - foc2);  // decFormat(ProductList[idx].price * unit);
        
        obj.value = unit == 0 ? "" : (unit * 1);
	
	calcGrandTotal();
}

function calcUnitAmt(i, obj) {
	var unit = obj.value;
	var thisform = document.frmSalesOrder;
        
	if (isNaN(unit)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		obj.value = "";
		obj.focus();
		return;
	}
           
  
	rate = eval("thisform.irate").value;
        ulang2 = eval("thisform.ulangi").value;
        
        qty = eval("thisform.Qty_" + i ).value;        
        disc = eval("thisform.Disc_" + i ).value;
	price = eval("thisform.iprice_" + i ).value;
        foc = eval("thisform.Foc_" + i ).value;
        

        var foc = eval("thisform.Foc_"+i);        
        foc.value = foc == 0 ? "0.00"  : decFormat( ( disc * (price * rate * qty) ) / 100 );        
        
        foc2 = eval("thisform.Foc_" + i ).value;
        
        var total = eval("thisform.Amt_"+i);      
        total.value = total == 0 ? ""  :formatAmount((price * rate * qty) - foc2);  // decFormat(ProductList[idx].price * unit);
                
        obj.value = unit == 0 ? "" : (unit * 1);
	
	calcGrandTotal();
}

function calcUnit1(idx, stock, obj) {
	var unit = obj.value;
        
	if (isNaN(unit)){
		alert("<i18n:label code="MSG_INVALID_QUANTITY_ORDER"/>");
		obj.value = "";
		obj.focus();
		return;
	}

	if (stock - unit < 0 ) {
		alert("<i18n:label code="Quantity Issue is greater than Stock Balance Quantity"/>");
		obj.value = "";
		obj.focus();
		return;
	} 
        
	var total = eval("Amt_"+ProductList[idx].ct+"_"+ProductList[idx].id);
	total.innerText = unit==0?"":formatAmount((ProductList[idx].price * unit));  // decFormat(ProductList[idx].price * unit);
	
	obj.value = unit == 0 ? "" : (unit * 1);
	
	calcGrandTotal();
}
	
function calcUnitFocLama(idx, qty) {
	var unit = qty.value;
	
	if (isNaN(unit)) {
		alert("<i18n:label code="MSG_INVALID_QUANTITY_FOC"/>");
		qty.value = "";
		qty.focus();
		return;
	}
	
	calcGrandTotal();
}

function calcDiscount(obj) {
	var discount = obj.value;
	
	if (isNaN(discount)) {
		alert("<i18n:label code="MSG_INVALID_VALUE"/>");
		obj.value = "";
		obj.focus();
		return;
	}
	
	calcGrandTotal();
}

function calcDiscountAmount(obj) {
	var vl = decFormat(obj.value * 1);

	if (!isPositive(vl)) {
		alert("<i18n:label code="MSG_DISCOUNT_POSTIVE"/>");
		obj.value = "";
		obj.focus();
		return;
	}
	
	obj.value = vl;
	calcGrandTotal();
}


function calcMiscAmount(obj) {
	obj.value = decFormat(obj.value * 1);
	calcGrandTotal();
}
		
function calcVoucher(amt) {
	var thisform = document.frmSalesOrder;
	var paid = decFormat(amt);
	
	lblPaymentVoucher.innerText = paid;
	thisform.PaymentVoucher.value = paid;
	calcAmountPaid(thisform.PaymentVoucher);
}
			
function calcGrandTotal() {
	var thisform = document.frmSalesOrder;
	selectedUnit = 0;
	selectedFocUnit = 0;
	total = 0;
	bv = 0;
        discount = 0;
	paid = 0;
        
        rate = eval("thisform.irate").value;
        ulang2 = eval("thisform.ulangi").value;
        
        // alert (ulang2);
        
	for (var i=1; i < 8; i++) {
		qty = eval("thisform.Qty_" + i ).value;
		price = eval("thisform.iprice_" + i ).value;
                foc = eval("thisform.Foc_" + i ).value;
                
		total += (price * rate * qty) - foc;
		// bv += ProductList[i].bv * qty;
		selectedUnit += qty * 1;
				
		if (eval("thisform.Foc_" + i) != null) {
			focQty = eval("thisform.Foc_" + i).value;
			selectedFocUnit += focQty * 1;
		}
	}

	// if (thisform.TotalBV != null)
	//	TotalBV.innerText = bv == 0 ? "0" : formatAmount(bv);
			
	Total.innerText = total == 0 ? "0.00" : formatAmount(total);  //decFormat(total);
	
	try{
		// Set Stockist Commission
		setPercentage(thisform,total);
	}catch(err){
	}
	
	if (total == 0 && selectedFocUnit == 0){
		disableSubmitBtn(true);
	} else {
		disableSubmitBtn(false);
	}
	
	if (thisform.Discount != null) {
		discount = total * (thisform.Discount.value / 100);
		DiscountAmt.innerText = discount == 0 ? "0.00" : decFormat(discount);
	}
	
	if (thisform.DiscountAmount != null) 
		total -= (replacePriceValue(thisform.DiscountAmount.value) * 1);
						
	if (thisform.AdminAmount != null)
		total += (thisform.AdminAmount.value * 1);

	/*
        if (thisform.DeliveryAmount != null)
		total += (thisform.DeliveryAmount.value * 1);
	*/
        // revisi tuk Deposit amount
	if (thisform.DeliveryAmount != null)
		total += (thisform.DeliveryAmount.value * -1);
                
	if (thisform.AmountReceived != null)
		thisform.TotalAdjustPayment.value = decFormat(thisform.AmountReceived.value - total);				
		
	if (thisform.TotalPaymentAdjust != null)
		total += (thisform.TotalPaymentAdjust.value * 1);
		
	orderPayment = total == 0 ? total : (total - discount);
	Grandtotal.innerText = orderPayment == 0 ? '0.00' : formatAmount(orderPayment); //decFormat(orderPayment);
	
	
	updatePaymentBalance();
}

function calcGrandTotalAsal() {
	var thisform = document.frmSalesOrder;
	selectedUnit = 0;
	selectedFocUnit = 0;
	total = 0;
	bv = 0;
        discount = 0;
	paid = 0;
  
	for (var i=0; i < ProductList.length; i++) {
		qty = eval("thisform.Qty_" + ProductList[i].ct + "_" + ProductList[i].id).value;
		
		total += ProductList[i].price * qty;
		bv += ProductList[i].bv * qty;
		selectedUnit += qty * 1;
				
		if (eval("thisform.Foc_" + ProductList[i].ct + "_" + ProductList[i].id) != null) {
			focQty = eval("thisform.Foc_" + ProductList[i].ct + "_" + ProductList[i].id).value;
			selectedFocUnit += focQty * 1;
		}
	}

	if (thisform.TotalBV != null)
		TotalBV.innerText = bv == 0 ? "0" : formatAmount(bv);
			
	Total.innerText = total == 0 ? "0.00" : formatAmount(total);  //decFormat(total);
	
	try{
		// Set Stockist Commission
		setPercentage(thisform,total);
	}catch(err){
	}
	
	if (total == 0 && selectedFocUnit == 0){
		disableSubmitBtn(true);
	} else {
		disableSubmitBtn(false);
	}
	
	if (thisform.Discount != null) {
		discount = total * (thisform.Discount.value / 100);
		DiscountAmt.innerText = discount == 0 ? "0.00" : decFormat(discount);
	}
	
	if (thisform.DiscountAmount != null) 
		total -= (replacePriceValue(thisform.DiscountAmount.value) * 1);
						
	if (thisform.AdminAmount != null)
		total += (thisform.AdminAmount.value * 1);

	if (thisform.DeliveryAmount != null)
		total += (thisform.DeliveryAmount.value * 1);
	
	if (thisform.AmountReceived != null)
		thisform.TotalAdjustPayment.value = decFormat(thisform.AmountReceived.value - total);				
		
	if (thisform.TotalPaymentAdjust != null)
		total += (thisform.TotalPaymentAdjust.value * 1);
		
	orderPayment = total == 0 ? total : (total - discount);
	Grandtotal.innerText = orderPayment == 0 ? '0.00' : formatAmount(orderPayment); //decFormat(orderPayment);
	
	
	updatePaymentBalance();
}

function calcAmountPaid(_this) {
	var thisform = document.frmSalesOrder;
	paid = 0;
	
	if (isNaN(_this.value)) {
	
		alert("<i18n:label code="MSG_INVALID_VALUE"/>");
		_this.value = "";
		_this.focus();
		return false;
		
	} 
		
	updatePaymentBalance();
	
	if (selectedUnit > 0) {
		if (Grandtotal.innerText.length == 0 || Grandtotal.innerText <= 0) {
		
			alert("<i18n:label code="MSG_ENTER_GRANDTOTAL"/>");
			_this.value = '';
			return false;
			
		} else {
		
			updatePaymentBalance();
			
		}
	}
}


function seletPaymentMode(objM, x) {
	
  var tes = objM.value;
  // alert('M' + x);
  
 updatePaymentBalance();
 
  		var amtPaid = replacePriceValue(amountPaid.innerText);
		amtPaid = amtPaid * 1;
		
		var grdTotal = replacePriceValue(Grandtotal.innerText);
		grdTotal = grdTotal * 1;
                
                selisih = 0;
                selisih = grdTotal - amtPaid;
                
                
  document.getElementById('amount_'+x).value= decFormat(selisih);
  // document.getElementById('amount_'+x).value= decFormat(replaceValueWithCommas(Grandtotal.innerHTML));
  
  var totalTerbayar1 = document.getElementById('amount_'+1).value;
  var totalTerbayar2 = document.getElementById('amount_'+2).value;
  
  // amountPaid.innerText = Grandtotal.innerHTML;    
  // document.getElementById('amount_'+x).value; // + document.getElementById('amount_'+2).value + document.getElementById('amount_'+3).value + document.getElementById('amount_'+4).value
  // formatAmount(balance.innerText)= (amountPaid.innerText).replace(/,/g,"") - totalTerbayar1.replace(/,/g,"");  
  // paymentChange.innerText = Grandtotal.innerHTML;

   /*  
   var x1 = document.getElementById('paymode_'+x).value;
   var y1 = x1.substr(0,4);
 
   if ( y1 == "CASH")
     {
       // alert("Payment CASH not use SWAP ")
       
       document.getElementById("expired_"+x).value = ""; 
       document.getElementById("owner_"+x).value = ""; 
       document.getElementById("amount_"+x).focus(); 
       
     }
    */
     
  updatePaymentBalance();
    
}

function seletPaymentModeWithInput(obj2, a) {
	
  var tes = obj2.value;
 
  
  //document.getElementById('amount_'+0).value=Total.innerHTML;
  
  var totalTerbayar0 = document.getElementById('amount_'+0).value;
  var totalTerbayar2 = document.getElementById('amount_'+2).value;
  
  var totalTerbayar = totalTerbayar0.replace(/,/g,"");// + totalTerbayar2.replace(/,/g,"");
  
  amountPaid.innerText = Total.innerHTML;
  
  var amountPaid2 = (amountPaid.innerText).replace(/,/g,"");
  
  tot  = amountPaid2 - totalTerbayar;
  
  
 // alert(a +  ' M ' + totalTerbayar );
  
 balance.innerText= formatAmount(tot);
  
  paymentChange.innerText = formatAmount(tot);
  
}

function updatePaymentBalance() {
	var thisform = document.frmSalesOrder;
	paid = 0;
  		
	for (var i=0; i < 4 ; i++) {
		var amt = eval("thisform.amount_" + i).value;
		paid += amt * 1;
	}
	
	amountPaid.innerText = paid == 0 ? "0.00" : formatAmount(paid); //decFormat(paid);
	
	var bal = (paid == 0) ? "0.00" : decFormat(replaceValueWithCommas(Grandtotal.innerText) - paid);
	
	if (thisform.paymentChangeObj != null) {
	  var change = "0.00";
		if (bal < 0) {
			change = decFormat(paid - replaceValueWithCommas(Grandtotal.innerText));
			bal = "0.00";
		}
		
		paymentChange.innerText = formatAmount(change);
	}
	
	balance.innerText = formatAmount(bal);	
}	


function updatePaymentBalanceAsal() {
	var thisform = document.frmSalesOrder;
	paid = 0;
  		
	for (var i=0; i < PaymodeList.length; i++) {
		var amt = eval("thisform.Paymode_" + PaymodeList[i].id).value;
		paid += amt * 1;
	}
	
	amountPaid.innerText = paid == 0 ? "0.00" : formatAmount(paid); //decFormat(paid);
	
	var bal = (paid == 0) ? "0.00" : decFormat(replaceValueWithCommas(Grandtotal.innerText) - paid);
	
	if (thisform.paymentChangeObj != null) {
	  var change = "0.00";
		if (bal < 0) {
			change = decFormat(paid - replaceValueWithCommas(Grandtotal.innerText));
			bal = "0.00";
		}
		
		paymentChange.innerText = formatAmount(change);
	}
	
	balance.innerText = formatAmount(bal);	
}

function updatePaymodeValue(_this) {
	
	if (_this != null) {
		
		if (orderPayment > 0)
			_this.value = decFormat(orderPayment);
		else
			_this.value = orderPayment;
	}
		
  calcAmountPaid(_this);
}	

/** Refund **/

function calcRefundAmount(obj) {

	if (isNaN(obj.value)) {
		alert("<i18n:label code="MSG_INVALID_VALUE"/>");
		obj.value = "";
		obj.focus();
	}

	calcRefundBalance();
}

function calcRefundBalance() {
	var thisform = document.frmSalesOrder;
	
	deductAmt = 0;
	
	if (thisform.MgmtAmount != null) {
		deductAmt = thisform.MgmtAmount.value * 1;
	}
	
	if (deductAmt > thisform.Grandtotal.value) {
		alert("<i18n:label code="MSG_DEDUCT_MORETHAN_GROSS"/>");
		thisform.MgmtAmount.value = "";
		return;
	}
		
	Refundtotal.innerText = formatAmount(thisform.Grandtotal.value - deductAmt);
	
	updateRefundPayment();
}

function updateRefundPayment() {
	var thisform = document.frmSalesOrder;
	paid = 0;
  		
	for (var i=0; i < PaymodeList.length; i++) {
		var amt = eval("thisform.Paymode_" + PaymodeList[i].id).value;
		paid += amt * 1;
	}

	amountPaid.innerText = paid == 0 ? "0.00" : formatAmount(paid); //decFormat(paid);
	balance.innerText = formatAmount(decFormat(replaceValueWithCommas(Refundtotal.innerText) - paid));
}
		
function disableSubmitBtn(truefalse) {
	var thisform = document.frmSalesOrder;
	thisform.btnSubmit.disabled = truefalse;
}

function decFormat(amount) {
	var i = parseFloat(amount);

	if (i == 0 || isNaN(i)) { i = 0.00; return i;}
	var minus = '';
	if (i < 0) { minus = '-'; }
	i = Math.abs(i);
	i = parseInt((i + .005) * 100);
	i = i / 100;
	s = new String(i);
	
	//if (s.indexOf('.') < 0) { s += '.00'; }	
	if (s.indexOf('.') > -1 && s.indexOf('.') == (s.length - 2)) { s += '0'; }
	s = minus + s;
	
	return s;
}

// Number formatting function
// copyright Stephen Chapman 24th March 2006
// permission to use this function is granted provided
// that this copyright notice is retained intact.
// dec - The second parameter is the number of decimal places that the number should have.
// thou - The third parameter is the thousands separator, e.g. coma(,)
// pnt - The fourth parameter is the decimal point, e.g. dot(.)
// curr1 - The fifth parameters are used for currency symbol before the value. 
// curr2 - The sixth parameters are used for currency symbol after the value. 
// n1 - The seventh parameters define the symbols to place before the number when the value is negative, e.g. -, CR
// n2 - The eighth  parameters define the symbols to place after the number when the value is negative, e.g. -, CR

function formatNumber(num,dec,thou,pnt,curr1,curr2,n1,n2)
{
	var x = Math.round(num * Math.pow(10,dec));
	
	if (x >= 0) 
		n1=n2='';
	
	var y = (''+Math.abs(x)).split('');
	var z = y.length - dec;
	y.splice(z, 0, pnt);
	
	while (z > 3) {
		z-=3; 
		y.splice(z,0,thou);
	}
	var r = curr1 + n1 + y.join('') + n2 + curr2;
	
	return r;
}

function formatAmount(num) {
	
  var out = formatNumber(num, 0, ',', '' , '' , '' , '-' , '');
  return out;
}

function replaceValueWithCommas(str) {
	
  var out = str.replace(/,/g,"");
  return out;
}
</script>