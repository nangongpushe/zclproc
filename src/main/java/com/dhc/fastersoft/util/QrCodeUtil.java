package com.dhc.fastersoft.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import org.apache.xmlgraphics.image.loader.spi.ImageImplRegistry;
import org.apache.xmlgraphics.image.loader.spi.ImagePreloader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class QrCodeUtil {

    private static Logger logger = LoggerFactory.getLogger(QrCodeUtil.class);

    private static int onColor = 0xFF000000;     //前景色
    private static int offColor = 0xFFFFFFFF;    //背景色
    /**
     * <p>Title: insertCodeToPicture</p>
     * <p>Description: 合同插入二维码</p>
     *
     * @param qrGen
     */
    @SuppressWarnings("unused")
    public String insertCodeToPicture(QRGen qrGen, String logoPaths) {

        ImageImplRegistry registry = ImageImplRegistry.getDefaultInstance();
        Iterator iterator = registry.getPreloaderIterator();

        while (iterator.hasNext()) {
            ImagePreloader nextElement = (ImagePreloader) iterator.next();
            String loaderName = nextElement.getClass().getName();
            if ("org.apache.fop.image.loader.batik.PreloaderSVG".equals(loaderName)) {
                iterator.remove();
            }
        }

        String imgPath = "";          //图片地址
        try {

            if (qrGen != null && StringUtil.isNotEmpty(qrGen.getContent())) {
                String contents = qrGen.getContent();//需要加密的信息
                contents = "https://phonecszjpt.chinaccs.cn:9446/phone/#/info";
                imgPath = qrCodePicturePath(contents, logoPaths);
            }

            return imgPath;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
        }
    }


    private String qrCodePicturePath(String contents, String logoPaths) {

        String imgPath = "";
        try {
            LogoConfig logoConfig = new LogoConfig();

            //加密contents
            //String encryptedContent = (new BASE64Encoder()).encodeBuffer(contents.getBytes(QRGen.CHARSET));
            BitMatrix bitMatrix = new MultiFormatWriter().encode(contents, BarcodeFormat.QR_CODE, 500, 500, this.getDecodeHintType());// 生成矩阵
            MatrixToImageConfig config = new MatrixToImageConfig(onColor, offColor);
            BufferedImage image = MatrixToImageWriter.toBufferedImage(bitMatrix,config);
            /**插入LOGO**/
            Graphics2D g = image.createGraphics();

            BufferedImage logo = ImageIO.read(new File(logoPaths));
            int widthLogo = logo.getWidth(null) > image.getWidth() * 3 / 10 ? (image.getWidth() * 3 / 10) : logo.getWidth(null),
                    heightLogo = logo.getHeight(null) > image.getHeight() * 3 / 10 ? (image.getHeight() * 3 / 10) : logo.getWidth(null);
            int x = (image.getWidth() - widthLogo) / 2;
            int y = (image.getHeight() - heightLogo) / 2;
            g.drawImage(logo, x, y, widthLogo, heightLogo, null);
//            g.setColor(Color.black);
//            g.setBackground(Color.WHITE);
            g.drawRoundRect(x, y, widthLogo, heightLogo, 15, 15);
            //g.setColor(logoConfig.getBorderColor());
            g.setStroke(new BasicStroke(logoConfig.getBorder()));
            g.drawRect(x, y, widthLogo, heightLogo);
            g.dispose();
            logo.flush();
            image.flush();
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            out.flush();
            ImageIO.write(image, "jpg", out);
            byte[] file_buff = out.toByteArray();
            logger.error("获取二维码内容:" + file_buff);

            FileUtil.getFileFromBytes(file_buff,"E://11.jpg");
//            FastDFSFile file = new FastDFSFile(UniqueIdUtil.getGuid(), file_buff, "jpg");
//            imgPath = FileManager.upload(file);
            logger.error("获取二维码生成路径:" + imgPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return imgPath;

    }


    public Map<EncodeHintType, Object> getDecodeHintType() {
        // 用于设置QR二维码参数
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        // 设置QR二维码的纠错级别（H为最高级别）具体级别信息
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        // 设置编码方式
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
        hints.put(EncodeHintType.MARGIN, 0);
        hints.put(EncodeHintType.MAX_SIZE, 350);
        hints.put(EncodeHintType.MIN_SIZE, 100);
        return hints;
    }


    public static void main(String[] args) {

        QRGen qrGen = new QRGen();
        qrGen.setContent("1111111111111");

        QrCodeUtil qrCodeCreateUtil = new QrCodeUtil();

        qrCodeCreateUtil.insertCodeToPicture(qrGen, "E:\\projects\\code\\zclproc\\zclproc\\src\\main\\webapp\\importTemplate\\zjcb.jpg");
    }
}


class LogoConfig {
    // logo默认边框颜色
    public static final Color DEFAULT_BORDERCOLOR = Color.WHITE;
    // logo默认边框宽度
    public static final int DEFAULT_BORDER = 2;
    // logo大小默认为照片的1/5
    public static final int DEFAULT_LOGOPART = 5;

    private final int border = DEFAULT_BORDER;
    private final Color borderColor;
    private final int logoPart;

    /**
     * Creates a default config with on color {@link #BLACK} and off color
     * {@link #WHITE}, generating normal black-on-white barcodes.
     */
    public LogoConfig() {
        this(DEFAULT_BORDERCOLOR, DEFAULT_LOGOPART);
    }

    public LogoConfig(Color borderColor, int logoPart) {
        this.borderColor = borderColor;
        this.logoPart = logoPart;
    }

    public Color getBorderColor() {
        return borderColor;
    }

    public int getBorder() {
        return border;
    }

    public int getLogoPart() {
        return logoPart;
    }
}


