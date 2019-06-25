function ajaxRequest(urls){
    var returncodes = $.ajax({url:urls,async:false});
    return returncodes.responseText;
}

function ajaxRequestAsync(urls){
    var returncodes = $.ajax({url:urls,async:true});
    return returncodes.responseText;
}

function messageTips(codeflag) {
    if(codeflag.indexOf("success")!=-1){
    	
    }
}

function messageStrTips(str) {
	layer.msg(str);
}

