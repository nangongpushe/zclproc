package com.dhc.fastersoft.util;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;

import java.io.File;
import java.io.IOException;

/**
 * 效果最好的一种方法，但是需要 window 环境，而且速度是最慢的需要安装 msofficeWord 以及 SaveAsPDFandXPS.exe (
 * word 的一个插件，用来把 word 转化为 pdf，可以不用安装，本次未安装测试通过 )
 * 
 * SaveAsPDFandXPS
 * 下载地址：http://www.microsoft.com/zh-cn/download/details.aspx?id=7 
 * jacob 包下载地址：http://sourceforge.net/projects/jacob-project/
 * 
 * jacob.jar 放在 E:\jdk1.5.0_14\jre\lib\ext 
 * jacob.dll 放在 E:\jdk1.5.0_14\jre\bin
 * 
 * @author u Y
 *
 */
public class WordToPdf {

    static final int wdDoNotSaveChanges = 0;// 不保存待定的更改。
    static final int wdFormatPDF = 17;// word转PDF 格式

    public static void main(String[] args) throws IOException {
        String source1 = "D:\\word\\simple.docx";
        String target1 = "D:\\word\\simple.pdf";
        WordToPdf pdf = new WordToPdf();
        pdf.word2pdf(source1, target1);
    }

    public static boolean word2pdf(String source, String target) {
        System.out.println("Word转PDF开始启动...");
        long start = System.currentTimeMillis();
        ActiveXComponent app = null;
        try {
            app = new ActiveXComponent("Word.Application");
            app.setProperty("Visible", false);
            Dispatch docs = app.getProperty("Documents").toDispatch();
            System.out.println("打开文档：" + source);
            Dispatch doc = Dispatch.call(docs, "Open", source, false, true).toDispatch();
            System.out.println("转换文档到PDF：" + target);
            File tofile = new File(target);
            if (tofile.exists()) {
                tofile.delete();
            }
            Dispatch.call(doc, "SaveAs", target, wdFormatPDF);

            Dispatch.call(doc, "Close", false);
            long end = System.currentTimeMillis();
            System.out.println("转换完成，用时：" + (end - start) + "ms");
            return true;
        } catch (Exception e) {
            System.out.println("Word转PDF出错：" + e.getMessage());
            return false;
        } finally {
            if (app != null) {
                app.invoke("Quit", wdDoNotSaveChanges);
            }
        }
    }

}