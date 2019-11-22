<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>异常信息</title>
<style type="text/css">
body {
	font-size: 12px;
	color: #4d4b4b;
}
</style>
<SCRIPT LANGUAGE="JavaScript">
<!--
//Ctr+e显示与隐藏错误信息
function keyDown(e) {
    var keyCode = e.keyCode || e.which || e.charCode;
    var ctrlKey = e.ctrlKey || e.metaKey;
    if(ctrlKey && keyCode == 69) {
        var obj=document.getElementById("divexception");
        if (obj.style.display.toLowerCase()=="none"){
            obj.style.display="block";
        }else{
            obj.style.display="none";
        }
    }
    e.preventDefault();
    return true;
}
document.onkeydown = keyDown;
//-->
</SCRIPT>
</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<table width="700" border="1" cellpadding="0" cellspacing="0"
		align="center">
		<tr>
			<td colspan="2" valign="top" bgcolor="#D6E2F2"
				class="style01 tdpadding">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td height="25" class="img01 titlefalse">异常信息</td>
					</tr>
					<tr>
						<td height="119" bgcolor="#FFFFFF" class="style01">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="20%" height="24" class="title01" align="center">
										系统异常，请联系管理员。</td>
								</tr>
								<tr>
									<td width="20%" height="24" class="title01" align="center">
										<button class="xui-btn museum-btn-brown"
											onclick="window.history.back();">返回</button>
									</td>
								</tr>

							</table>
						</td>
					</tr>
					<tr>
						<td>
							<div align=center style="display: none; height: 60%"
								id=divexception>
								<TEXTAREA NAME="" ROWS="8" COLS="100">
                     400
                      </TEXTAREA>
								<div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

</body>
</html>