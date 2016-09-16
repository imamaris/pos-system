<script language="Javascript">
/** variables **/

cartList = new Array();

function item(id) {
	this.id = id;
}

function tableHead() {

	var x = document.getElementById('Cart').rows[0].cells;
	var column = 7;
	
	
	if (cartList.length > 0){
		for (var i=0; i<column; i++) {
			switch (i)
			{
				case 0:
					x[i].innerHTML = '<i18n:label code="GENERAL_NUMBER"/>';
					x[i].colSpan = "1";
					x[i].align = "left";
				break;
				case 1:
					x[i].innerHTML = '<i18n:label code="PRODUCT_SKU_CODE"/>';
				break;
				case 2:
					x[i].innerHTML = '<i18n:label code="PRODUCT_NAME"/>';
				break;
				case 6:
					x[i].innerHTML = '<i18n:label code="GENERAL_TOTAL_AMOUNT"/>';
					x[i].align = "right";
				break;
				case 5:
					x[i].innerHTML = '<i18n:label code="GENERAL_TOTAL"/> PV';
					x[i].align = "right";
				break;
				case 3:
					x[i].innerHTML = '<i18n:label code="GENERAL_QTY"/>';
					x[i].align = "center";
				break;
				case 4:
					x[i].innerHTML = '<i18n:label code="GENERAL_QTYFOC"/>';
					x[i].align = "center";
				break;
			}
		}
	}
	else {
		x[0].innerHTML = "No Order Items";
		x[0].colSpan = "7";
		x[0].align="center";
		
		for (var i=1; i<column; i++)
			x[i].innerHTML = "";
	}
}

function addToCart(no, idx) {
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').insertRow(no);
	
	var data = new Array();
	var column = 7;
	var code = document.getElementById('code_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var name = document.getElementById('name_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var bv = document.getElementById('bv_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	var foc = eval('thisform.Foc_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	
	for (var i=0; i<column; i++) {
		data[i] = x.insertCell(i);
		switch (i)
		{
			case 0:
				data[i].innerHTML = no+".";
			break;
			case 1:
				data[i].innerHTML = code.innerHTML;
			break;
			case 2:
				data[i].innerHTML = name.innerHTML;
			break;
			case 6:
				var out = replacePriceValue(price.innerHTML);
				data[i].innerHTML = formatAmount(parseFloat(out)*qty);
				data[i].align = "right";
			break;
			case 5:
				data[i].innerHTML = formatAmount(parseFloat(bv.innerHTML)*qty);
				data[i].align = "right";
			break;
			case 3:
				data[i].innerHTML = qty;
				data[i].align = "center";
			break;
			case 4:
				data[i].innerHTML = foc;
				data[i].align = "center";
			break;
		}
	}
}

function updateCart(row, idx) {
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').rows;
	var y = x[row].cells;
	
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var bv = document.getElementById('bv_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	var foc = eval('thisform.Foc_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;

	y[3].innerHTML = qty;
	y[4].innerHTML = foc;
	y[5].innerHTML = formatAmount(parseFloat(bv.innerHTML)*qty);
	
	var out = replacePriceValue(price.innerHTML)
	y[6].innerHTML = formatAmount(parseFloat(out)*qty);
}

function Cart(idx) {
	var thisform = document.frmSalesOrder;
	var qty = eval("thisform.Qty_"+ ProductList[idx].ct + "_" + ProductList[idx].id).value;
	var foc = eval("thisform.Foc_"+ ProductList[idx].ct + "_" + ProductList[idx].id).value;
	//check qty.length and foc.length of item if > 0
	if(qty.length > 0 || foc.length > 0) {
		//if no item in cart
		if(cartList.length == 0) {
			//add item to cart and display
			cartList[cartList.length] = new item(idx);
			tableHead();
			addToCart(cartList.length, idx);
		}
		//else if got item in cart
		else {
			var inCart = 0;
			
			for (var i=0; i<cartList.length; i++) {
				if(cartList[i].id == idx) {
					updateCart((i+1), idx);
					inCart = 1;
				}
			}					
			// if not in cart list add and display
			if(inCart == 0) {
				cartList[cartList.length] = new item(idx);
				addToCart(cartList.length, idx);
			}
		}
	}
	//else if qty.length and foc.length of item = 0
	else {
		//if got item in cart
		if (cartList.length > 0) {
			for (var i=0; i<cartList.length; i++) {
				//check item if same delete from cart
				if (cartList[i].id == idx) {
					deleteFromCart(i+1);	
					cartList.splice(i,1);
					refreshCart(cartList.length);
					
					if (cartList.length == 0) {
						tableHead();
					}
				}				
			}
		}
	}		
}

/*
*	for cgn sales
*/
function cgn_tableHead() {

	var x = document.getElementById('Cart').rows[0].cells;
	var column = 5;
	
	
	if (cartList.length > 0){
		for (var i=0; i<column; i++) {
			switch (i)
			{
				case 0:
					x[i].innerHTML = 'No.';
					x[i].colSpan = "1";
					x[i].align = "left";
				break;
				case 1:
					x[i].innerHTML = 'Sales Item Code';
				break;
				case 2:
					x[i].innerHTML = 'Sales Item Name';
				break;
				case 4:
					x[i].innerHTML = 'Total Price';
					x[i].align = "right";
				break;						
				case 3:
					x[i].innerHTML = 'Total Quantity';
					x[i].align = "center";
				break;
			}
		}
	}
	else {
		x[0].innerHTML = "No Purchase Item";
		x[0].colSpan = "5";
		x[0].align="center";
		
		for (var i=1; i<column; i++)
			x[i].innerHTML = "";
	}
}

function cgn_addToCart(no, idx) {
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').insertRow(no);
	
	var data = new Array();
	var column = 5;
	var code = document.getElementById('code_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var name = document.getElementById('name_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	
	for (var i=0; i<column; i++) {
		data[i] = x.insertCell(i);
		switch (i)
		{
			case 0:
				data[i].innerHTML = no+".";
			break;
			case 1:
				data[i].innerHTML = code.innerHTML;
			break;
			case 2:
				data[i].innerHTML = name.innerHTML;
			break;
			case 4:
				var out = replacePriceValue(price.innerHTML);
				data[i].innerHTML = formatAmount(parseFloat(out)*qty);
				data[i].align = "right";
			break;
			case 3:
				data[i].innerHTML = qty;
				data[i].align = "center";
			break;
		}
	}
}

function cgn_updateCart(row, idx) {
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').rows;
	var y = x[row].cells;
	
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;

	y[3].innerHTML = qty;
	
	var out = replacePriceValue(price.innerHTML);
	y[4].innerHTML = formatAmount(parseFloat(out)*qty);
}

function cgn_Cart(idx) {
	var thisform = document.frmSalesOrder;
	var qty = eval("thisform.Qty_"+ ProductList[idx].ct + "_" + ProductList[idx].id).value;
	//check qty.length 
	if(qty.length > 0) {
		//if no item in cart
		if(cartList.length == 0) {
			//add item to cart and display
			cartList[cartList.length] = new item(idx);
			cgn_tableHead();
			cgn_addToCart(cartList.length, idx);
		}
		//else if got item in cart
		else {
			var inCart = 0;
			
			for (var i=0; i<cartList.length; i++) {
				if(cartList[i].id == idx) {
					cgn_updateCart((i+1), idx);
					inCart = 1;
				}
			}					
			// if not in cart list add and display
			if(inCart == 0) {
				cartList[cartList.length] = new item(idx);
				cgn_addToCart(cartList.length, idx);
			}
		}
	}
	//else if qty.length of item = 0
	else {
		//if got item in cart
		if (cartList.length > 0) {
			for (var i=0; i<cartList.length; i++) {
				//check item if same delete from cart
				if (cartList[i].id == idx) {
					deleteFromCart(i+1);	
					cartList.splice(i,1);
					refreshCart(cartList.length);
					
					if (cartList.length == 0) {
						cgn_tableHead();
					}
				}				
			}
		}
	}		
}

/*
*	for  edp purchase
*/
function edp_init() {
	var thisform = document.frmSalesOrder;
	for (var i=0; i < ProductList.length; i++) {
			//part edit by tuckhoh
			var qty = eval("thisform.Qty_"+ ProductList[i].ct + "_" + ProductList[i].id).value;
			
			if(qty.length > 0) {
				cartList[cartList.length] = new item(i);
				edp_tableHead();
				edp_addToCart(cartList.length, i);
			}
	}
}
function edp_tableHead() {

	var x = document.getElementById('Cart').rows[0].cells;
	var column = 6;
	
	
	if (cartList.length > 0){
		for (var i=0; i<column; i++) {
			switch (i)
			{
				case 0:
					x[i].innerHTML = '<i18n:label code="GENERAL_NUMBER"/>';
					x[i].colSpan = "1";
					x[i].align = "left";
				break;
				case 1:
					x[i].innerHTML = '<i18n:label code="PRODUCT_SKU_CODE"/>';
				break;
				case 2:
					x[i].innerHTML = '<i18n:label code="PRODUCT_NAME"/>';
				break;
				case 5:
					x[i].innerHTML = '<i18n:label code="GENERAL_TOTAL_AMOUNT"/>';
					x[i].align = "right";
				break;						
				case 3:
					x[i].innerHTML = '<i18n:label code="GENERAL_QTY"/>';
					x[i].align = "center";
				break;
				case 4:
					x[i].innerHTML = '<i18n:label code="GENERAL_TOTAL"/> PV';
					x[i].align = "right";
				break;
			}
		}
	}
	else {
		x[0].innerHTML = "No Order Items";
		x[0].colSpan = "5";
		x[0].align="center";
		
		for (var i=1; i<column; i++)
			x[i].innerHTML = "";
	}
}

function edp_addToCart(no, idx) {
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').insertRow(no);
	
	var data = new Array();
	var column = 6;
	var code = document.getElementById('code_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var name = document.getElementById('name_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var bv = document.getElementById('bv_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	
	for (var i=0; i<column; i++) {
		data[i] = x.insertCell(i);
		switch (i)
		{
			case 0:
				data[i].innerHTML = no+".";
			break;
			case 1:
				data[i].innerHTML = code.innerHTML;
			break;
			case 2:
				data[i].innerHTML = name.innerHTML;
			break;
			case 5:
				var out = replacePriceValue(price.innerHTML);
				data[i].innerHTML = formatAmount(parseFloat(out)*qty);
				data[i].align = "right";
			break;
			case 4:
				data[i].innerHTML = formatAmount(parseFloat(bv.innerHTML)*qty);
				data[i].align = "right";
			break;
			case 3:
				data[i].innerHTML = qty;
				data[i].align = "center";
			break;
		}
	}
}

function edp_updateCart(row, idx) {
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').rows;
	var y = x[row].cells;
	
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var bv = document.getElementById('bv_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;

	y[3].innerHTML = qty;
	y[4].innerHTML = parseFloat(bv.innerHTML)*qty;
	
	var out = replacePriceValue(price.innerHTML);
	y[5].innerHTML = (parseFloat(out)*qty);
}

function edp_Cart(idx) {
	var thisform = document.frmSalesOrder;
	var qty = eval("thisform.Qty_"+ ProductList[idx].ct + "_" + ProductList[idx].id).value;
	//check qty.length 
	if(qty.length > 0) {
		//if no item in cart
		if(cartList.length == 0) {
			//add item to cart and display
			cartList[cartList.length] = new item(idx);
			edp_tableHead();
			edp_addToCart(cartList.length, idx);
		}
		//else if got item in cart
		else {
			var inCart = 0;
			
			for (var i=0; i<cartList.length; i++) {
				if(cartList[i].id == idx) {
					edp_updateCart((i+1), idx);
					inCart = 1;
				}
			}					
			// if not in cart list add and display
			if(inCart == 0) {
				cartList[cartList.length] = new item(idx);
				edp_addToCart(cartList.length, idx);
			}
		}
	}
	//else if qty.length of item = 0
	else {
		//if got item in cart
		if (cartList.length > 0) {
			for (var i=0; i<cartList.length; i++) {
				//check item if same delete from cart
				if (cartList[i].id == idx) {
					deleteFromCart(i+1);	
					cartList.splice(i,1);
					refreshCart(cartList.length);
					
					if (cartList.length == 0) {
						edp_tableHead();
					}
				}				
			}
		}
	}		
}

/** No Bv Cart - Retailer & Staff **/
  
function noBvCart(idx) {
	var thisform = document.frmSalesOrder;
	
	var qty = eval("thisform.Qty_"+ ProductList[idx].ct + "_" + ProductList[idx].id).value;
	var foc = eval("thisform.Foc_"+ ProductList[idx].ct + "_" + ProductList[idx].id).value;
	
	if (qty.length > 0 || foc.length > 0) {
    
		// addItem if no item in cart
		if (cartList.length == 0) {
			
			cartList[cartList.length] = new item(idx);
			noBvTableHead();
			addToNoBvCart(cartList.length, idx);
			
		} else {
			var inCart = 0;
			
			for (var i=0; i<cartList.length; i++) {
				if(cartList[i].id == idx) {
					updateNoBvCart((i+1), idx);
					inCart = 1;
				}
			}
								
			if(inCart == 0) {
				cartList[cartList.length] = new item(idx);
				addToNoBvCart(cartList.length, idx);
			}
		}
		
	} else {

		if (cartList.length > 0) {
			
			// delete if in cart
			for (var i=0; i<cartList.length; i++) {

				if (cartList[i].id == idx) {
					deleteFromCart(i+1);	
					cartList.splice(i,1);
					refreshCart(cartList.length);
					
					if (cartList.length == 0) {
						noBvTableHead();
					}
				}				
			}
			
		}
	}		
}

function addToNoBvCart(no, idx) {
	var column = 6;
	var data = new Array();
	
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').insertRow(no);
	var code = document.getElementById('code_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var name = document.getElementById('name_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	var foc = eval('thisform.Foc_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	
	for (var i=0; i<column; i++) {
		
		data[i] = x.insertCell(i);
		
		switch (i) {
			case 0:
				data[i].innerHTML = no+".";
			break;
			case 1:
				data[i].innerHTML = code.innerHTML;
			break;
			case 2:
				data[i].innerHTML = name.innerHTML;
			break;
			case 3:
				data[i].innerHTML = qty;
				data[i].align = "center";
			break;
			case 4:
				data[i].innerHTML = foc;
				data[i].align = "center";
			break;
			case 5:
				var out = replacePriceValue(price.innerHTML);
				data[i].innerHTML = formatAmount(parseFloat(out)*qty);
				data[i].align = "right";
			break;
			
		} // end switch
	} // end for
}

function updateNoBvCart(row, idx) {
	var thisform = document.frmSalesOrder;
	var x = document.getElementById('Cart').rows;
	var y = x[row].cells;
	
	var price = document.getElementById('price_'+ProductList[idx].ct +'_'+ProductList[idx].id);
	var qty = eval('thisform.Qty_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;
	var foc = eval('thisform.Foc_'+ProductList[idx].ct +'_'+ProductList[idx].id).value;

	y[3].innerHTML = qty;
	y[4].innerHTML = foc;
	
	var out = replacePriceValue(price.innerHTML);
	y[5].innerHTML = formatAmount(parseFloat(out)*qty);
}

function noBvTableHead() {

	var column = 6;
	
	var x = document.getElementById('Cart').rows[0].cells;
	
	if (cartList.length > 0){
		
		for (var i=0; i<column; i++) {
			
			switch (i) {
				case 0:
					x[i].innerHTML = 'No.';
					x[i].colSpan = "1";
					x[i].align = "left";
				break;
				case 1:
					x[i].innerHTML = '<i18n:label code="PRODUCT_SKU_CODE"/>';
				break;
				case 2:
					x[i].innerHTML = '<i18n:label code="PRODUCT_NAME"/>';
				break;
				case 3:
					x[i].innerHTML = '<i18n:label code="GENERAL_QTY"/>';
					x[i].align = "center";
				break;
				case 4:
					x[i].innerHTML = '<i18n:label code="GENERAL_QTYFOC"/>';
					x[i].align = "center";
				break;
				case 5:
					x[i].innerHTML = '<i18n:label code="GENERAL_TOTAL_AMOUNT"/>';
					x[i].align = "right";
				break;
				
			} // end switch
		} // end for
		
	} else {
		x[0].innerHTML = "No Order Items";
		x[0].colSpan = "6";
		x[0].align="center";
		
		for (var i=1; i<column; i++)
			x[i].innerHTML = "";
	}
}


/** Utils **/

function deleteFromCart(row) {
	document.getElementById('Cart').deleteRow(row)
}
 
function refreshCart(no) {
	var x = document.getElementById('Cart').rows;
	
	for(var i=1; i<no+1; i++) {
		var y = x[i].cells;
		y[0].innerHTML = (i)+".";
	}
}

function replacePriceValue(str) {
	
  var out = str.replace(/,/g,"");
  return out;
}

</script>