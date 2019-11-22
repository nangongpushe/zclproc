package com.dhc.fastersoft.service.system;



import com.dhc.fastersoft.entity.RotateTakeMain;

public interface SysLadingReceiptService {
	/**
	 *将省平台的提货单基本信息下发到浪潮
	 */
	String sendMessage(RotateTakeMain rotateTakeMain);
}
