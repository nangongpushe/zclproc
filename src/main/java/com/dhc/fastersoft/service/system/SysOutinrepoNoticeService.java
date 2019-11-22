package com.dhc.fastersoft.service.system;


import com.dhc.fastersoft.entity.RotateNotice;

public interface SysOutinrepoNoticeService {
	/**
	 *将省平台的出入库通知书下发到出库平台
	 */
	String sendMessage(RotateNotice notice);
	/**
	 *将省平台的出入库通知书下发到浪潮
	 */
	String sendMessageToLangchao(RotateNotice notice);
}
