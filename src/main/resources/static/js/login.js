  document.onkeydown = function (event) {
        var e = event || window.event;
        if (e && e.keyCode == 13) { //回车键的键值为13
            $("#loginbutton").click(); //调用登录按钮的登录事件
        }
    }; 
$(function  () {
	var flag_login = $('#login_flag').val();
	
    layui.use('form', function(){
        var form = layui.form;
        form.on('submit', function(){
            var username = $("#username").val();
            var passwords = hex_md5( $("#passwords").val());
            $.ajax({
                type: "POST",//方法类型
                url: contentp_path+'/console/logindowith.do',
                data: {passwords:passwords,username:username,code:''},
                async:false,
                success: function (result) {
                    if(result=='success'){ 
                        window.location.href=contentp_path+'/console/index.do';
                    }else if(result == 'ERROT_STATUS'){
                    	messageStrTips('用户状态错误，请联系管理人员核实身份！');
                    }else{
                        messageStrTips('登陆失败，身份信息错误！');
                    }
                },
                error : function() {
                    messageStrTips('登陆失败，请稍后重试！');
                }
            });
            return false;
        });
    });
    
    if('NO_LOGIN'==flag_login || 'NO_TIMEOUT'==flag_login){
    	$("#no_login_span").show();
    	setTimeout(function(){
    		$("#no_login_span").hide();
    	}, 3000);
	}else{
		autologinList();
	}
});



/*************** 发送验证码 ******************/
function sendMessage(){
    var tel = $("#telephone").val();
    $.ajax({
        type: "POST",//方法类型
        url: contentp_path+'/pub/sendValidCode.do',
        data: {tel:tel},
        success: function (result) {
            messageStrTips('短信发送成功，请注意查收！');
        },
        error : function() {
            messageStrTips('短信发送失败，请稍后重试！');
        }
    });
}

/************** 如果已登陆，自动登陆 *****************/
function autologinList() {
    $.ajax({
        type: "GET",//方法类型
        url: contentp_path+'getLoginUser',
        success: function (result) {
            if(Number(result) > 0){
                window.location.href=contentp_path+'index';
            }
        }
    });
}

