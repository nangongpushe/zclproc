package com.zhuozhengsoft.pageoffice;

/**
 * pageOffice 打开文档模式
 */
public enum OpenModeType {
    docRevisionOnly,//    Word 强制保留痕迹模式。
    docAdmin,//Word 核稿模式。
    docNormalEdit,// Word 普通编辑模式。
    docReadOnly,// Word 只读模式。
    docHandwritingOnly,//  Word 手写模式。
    docSubmitForm,//   Word 表单提交模式。
    xlsNormalEdit,// Excel 普通编辑模式。
    xlsReadOnly,//  Excel 只读模式。
    xlsSubmitForm,// Excel 表单提交模式。
    pptNormalEdit,//  PowerPoint 普通编辑模式。
    pptReadOnly,// PowerPoint 只读模式。
    vsdNormalEdit,// Visio 普通编辑模式。
    mppNormalEdit;//  Project 普通编辑模式。

    private OpenModeType() {
    }
}