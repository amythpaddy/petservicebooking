String url = 'https://plutorum:plutoru*\$*\$@plutorum.com/mobile_paytm_payment';
String htmlPostData(leadId, leadType) =>
    '<html>' +
    '<body onload="document.f.submit();">' +
    '<form id="f" name="f" method="post" action="$url">' +
    '<input type="hidden" name="LEAD_ID" value="$leadId">' +
    '<input type="hidden" name="LEAD_TYPE" value="$leadType">' +
    '</form>' +
    '</body>' +
    '</html>';
