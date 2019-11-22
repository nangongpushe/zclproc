package com.dhc.fastersoft.util;

import org.apache.commons.io.FileUtils;
import org.apache.http.Consts;
import org.apache.http.Header;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import javax.net.ssl.*;
import java.io.*;
import java.net.*;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author jinge
 * @create 2018-07-26 9:21
 */
public class HttpUtil {
    private static ContentType TEXT_PLAIN_UTF8 = ContentType.create("text/plain", Consts.UTF_8);

    private static Logger logger = LoggerFactory.getLogger(HttpUtil.class);

    private static SSLContext sslcontext = null;

    private static X509TrustManager tm = null;

    private static SSLConnectionSocketFactory sslsf = null;

    static {
        tm = new X509TrustManager() {
            @Override
            public void checkClientTrusted(X509Certificate[] xcs, String string)
                    throws CertificateException {
            }
            @Override
            public void checkServerTrusted(X509Certificate[] xcs, String string)
                    throws CertificateException {
            }
            @Override
            public X509Certificate[] getAcceptedIssuers() {
                return null;
            }
        };

        try {
            sslcontext = SSLContext.getInstance("SSL");
            sslcontext.init(null, new TrustManager[]{tm}, null);
        } catch (NoSuchAlgorithmException e) {
            logger.error("error", e);
        } catch (KeyManagementException e) {
            logger.error("error", e);
        }

        sslsf = new SSLConnectionSocketFactory(sslcontext,
                new String[]{"TLSv1"}, null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
    }

    public static CloseableHttpResponse get(String url)
            throws IOException, KeyManagementException, NoSuchAlgorithmException {
        CloseableHttpClient httpclient = createHttpClient(url);
        HttpGet httpGet = new HttpGet(url);
        CloseableHttpResponse response = httpclient.execute(httpGet);
        return response;
    }

    public static void getFile(String url, File file) throws NoSuchAlgorithmException, KeyManagementException, IOException {
        CloseableHttpClient httpclient = createHttpClient(url);
        HttpGet httpGet = new HttpGet(url);
        httpGet.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0");
        httpGet.setHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        httpGet.setHeader("Accept-Language", "en-US,zh-CN;q=0.8,zh;q=0.5,en;q=0.3");
        httpGet.setHeader("Connection", "keep-alive");
        httpGet.setHeader("Pragma", "no-cache");
        httpGet.setHeader("Cache-Control", "no-cache");
        httpGet.setHeader("Accept-Encoding", "gzip, deflate");

        CloseableHttpResponse response = httpclient.execute(httpGet);
        byte[] bytes = EntityUtils.toByteArray(response.getEntity());

        FileUtils.writeByteArrayToFile(file, bytes);
    }

    public static byte[] getFile(String url) throws NoSuchAlgorithmException, KeyManagementException, IOException {
        CloseableHttpClient httpclient = createHttpClient(url);
        HttpGet httpGet = new HttpGet(url);
        httpGet.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0");
        httpGet.setHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        httpGet.setHeader("Accept-Language", "en-US,zh-CN;q=0.8,zh;q=0.5,en;q=0.3");
        httpGet.setHeader("Connection", "keep-alive");
        httpGet.setHeader("Pragma", "no-cache");
        httpGet.setHeader("Cache-Control", "no-cache");
        httpGet.setHeader("Accept-Encoding", "gzip, deflate");

        CloseableHttpResponse response = httpclient.execute(httpGet);
        byte[] bytes = EntityUtils.toByteArray(response.getEntity());

        return bytes;
    }

    public static String getAsString(String url) throws IOException, KeyManagementException, NoSuchAlgorithmException {
        CloseableHttpClient httpclient = createHttpClient(url);

        HttpGet httpGet = new HttpGet(url);
        CloseableHttpResponse response = httpclient.execute(httpGet);
        return EntityUtils.toString(response.getEntity());
    }

    public static String post(String urlStr, MultipartFile mfile) {
        String res = "";
        HttpURLConnection conn = null;
        String BOUNDARY = "-----------------s----------123821742118716";
        try {
            URL url = new URL(urlStr);
            conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(30000);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");

            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

            OutputStream out = new DataOutputStream(conn.getOutputStream());

            if (mfile != null) {
                String filename = mfile.getOriginalFilename();

                String contentType = mfile.getContentType();
                StringBuffer strBuf = new StringBuffer();
                strBuf.append("\r\n").append("--").append(BOUNDARY).append("\r\n");

                strBuf.append("Content-Disposition: form-data; name=\"media\"; filename=\"" + filename + "\"\r\n");

                strBuf.append("Content-Type:" + contentType + "\r\n\r\n");

                out.write(strBuf.toString().getBytes());

                DataInputStream in = new DataInputStream(mfile.getInputStream());
                int bytes = 0;
                byte[] bufferOut = new byte[1024];
                while ((bytes = in.read(bufferOut)) != -1) {
                    out.write(bufferOut, 0, bytes);
                }
                in.close();
            }

            byte[] endData = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();
            out.write(endData);
            out.flush();
            out.close();

            StringBuffer strBuf = new StringBuffer();
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = null;
            while ((line = reader.readLine()) != null) {
                strBuf.append(line).append("\n");
            }
            res = strBuf.toString();
            reader.close();
            reader = null;
        } catch (Exception e) {
            System.out.println("发送POST请求出错。" + urlStr);
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.disconnect();
                conn = null;
            }
        }
        return res;
    }

    public static String post(String url, Map<String, String> params, Map<String, String> heads) throws IOException, KeyManagementException, NoSuchAlgorithmException {
        CloseableHttpClient httpclient = createHttpClient(url);
        HttpPost httpPost = new HttpPost(url);
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        if (params != null) {
            for (Map.Entry entry : params.entrySet()) {
                nvps.add(new BasicNameValuePair((String) entry.getKey(), (String) entry.getValue()));
            }

        }

        if (heads != null) {
            for (Map.Entry entry : heads.entrySet()) {
                httpPost.setHeader((String) entry.getKey(), (String) entry.getValue());
            }
        }
        httpPost.setEntity(new UrlEncodedFormEntity(nvps,"UTF-8"));
        CloseableHttpResponse response = httpclient.execute(httpPost);
        return EntityUtils.toString(response.getEntity(),"UTF-8");
    }

    public static String post(String url, String body, Map<String, String> heads) throws IOException, KeyManagementException, NoSuchAlgorithmException {
        CloseableHttpClient httpclient = createHttpClient(url);
        HttpPost httpPost = new HttpPost(url);

        httpPost.setEntity(new StringEntity(body));

        if (heads != null) {
            for (Map.Entry entry : heads.entrySet()) {
                httpPost.setHeader((String) entry.getKey(), (String) entry.getValue());
            }
        }

        CloseableHttpResponse response = httpclient.execute(httpPost);
        return EntityUtils.toString(response.getEntity());
    }



    public static String formPost(String url, Map<String, String> params, Map<String, String> headers) throws IOException, KeyManagementException, NoSuchAlgorithmException {
        CloseableHttpClient httpclient = createHttpClient(url);
        HttpPost httpPost = new HttpPost(url);

        StringBuffer stringBuffer = new StringBuffer();

        if (params != null) {
            for (Map.Entry entry : params.entrySet()) {
                stringBuffer.append((String) entry.getKey() + "=" + URLEncoder.encode((String) entry.getValue(), "UTF-8") + "&");
            }
        }
        StringEntity stringEntity = new StringEntity(stringBuffer.toString());

        if (headers != null) {
            for (Map.Entry entry : headers.entrySet()) {
                httpPost.setHeader((String) entry.getKey(), (String) entry.getValue());
            }
        }

        httpPost.setEntity(stringEntity);

        CloseableHttpResponse response = httpclient.execute(httpPost);
        return EntityUtils.toString(response.getEntity());
    }




    public static String postJson(String url, String json) {
        URL u = null;
        HttpURLConnection con = null;
        OutputStreamWriter osw = null;

        StringBuffer sb = new StringBuffer();
        sb.append(json);
        try {
            u = new URL(url);
            con = (HttpURLConnection) u.openConnection();

            con.setRequestMethod("POST");
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setUseCaches(false);
            con.setRequestProperty("Content-Type", "application/json");

            osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");

            osw.write(sb.toString());
            osw.flush();
            osw.close();
        } catch (Exception e) {
            e.printStackTrace();

            if (con != null) {
                con.disconnect();
            }
            if (osw != null) {
                try {
                    osw.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (con != null) {
                con.disconnect();
            }
            if (osw != null) {
                try {
                    osw.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }

        StringBuffer buffer = new StringBuffer();
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
            String temp;
            while ((temp = br.readLine()) != null) {
                buffer.append(temp);
                buffer.append("\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return buffer.toString();
    }

    private static String getFileName(CloseableHttpResponse response) {
        Header disposition = response.getFirstHeader("Content-Disposition");

        String name = disposition.getValue().split(";")[1];
        name = name.substring(name.lastIndexOf(61) + 2).trim();
        name = name.substring(0, name.lastIndexOf(34));

        return name;
    }

    private static CloseableHttpClient createHttpClient(String url) throws KeyManagementException, NoSuchAlgorithmException, MalformedURLException {
        URL u = new URL(url);
        CloseableHttpClient httpclient = null;
        if ("https".equals(u.getProtocol())) {
            logger.trace("https");
            httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
        } else {
            logger.trace("http");
            httpclient = HttpClients.createDefault();
        }

        return httpclient;
    }

    public static CloseableHttpClient createHttpsClient() throws KeyManagementException, NoSuchAlgorithmException, MalformedURLException {
        CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();

        return httpclient;
    }

    public static String httpsRequest(String requestUrl, String requestMethod, String outputStr) {
        try {
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");

            sslContext.init(null, new TrustManager[]{tm}, null);

            SSLSocketFactory ssf = sslContext.getSocketFactory();
            URL url = new URL(requestUrl);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(ssf);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);

            conn.setRequestMethod(requestMethod);
            conn.setRequestProperty("content-type", "application/x-www-form-urlencoded");

            if (outputStr != null) {
                OutputStream outputStream = conn.getOutputStream();

                outputStream.write(outputStr.getBytes("UTF-8"));
                outputStream.close();
            }

            InputStream inputStream = conn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");

            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

            String str = null;
            StringBuffer buffer = new StringBuffer();
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }

            bufferedReader.close();
            inputStreamReader.close();
            inputStream.close();
            inputStream = null;
            conn.disconnect();
            return buffer.toString();
        } catch (ConnectException ce) {
            logger.error("连接超时：{}", ce);
        } catch (Exception e) {
            logger.error("https请求异常：{}", e);
        }
        return null;
    }

    public static String urlEncodeUTF8(String source) {
        String result = source;
        try {
            result = URLEncoder.encode(source, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String sendPost(String url) {
        PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);

            URLConnection conn = realUrl.openConnection();

            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");

            conn.setDoOutput(true);
            conn.setDoInput(true);

            out = new PrintWriter(conn.getOutputStream());

            out.flush();

            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null)
                result = result + line;
        } catch (Exception e) {
            System.out.println("发送 POST 请求出现异常！" + e);
            e.printStackTrace();
            try {
                if (out != null) {
                    out.close();
                }
                if (in != null)
                    in.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (in != null)
                    in.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    public static String postBody(String url, String body) {
        OutputStreamWriter out = null;
        try {
            URL connectURL = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) connectURL.openConnection();
            conn.setReadTimeout(100000);
            conn.setConnectTimeout(100000);
            conn.setDoInput(true);
            conn.setDoOutput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Connection", "Keep-Alive");
            out = new OutputStreamWriter(conn.getOutputStream());
            out.write(body);
            out.flush();

            StringBuffer inputb = new StringBuffer();
            InputStream is = conn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(is, "UTF-8");
            int read;
            while ((read = inputStreamReader.read()) >= 0) {
                inputb.append((char) read);
            }
            return inputb.toString();
        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            try {
                if (out != null)
                {out.close();}
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return null;
    }

    static {
        tm = new X509TrustManager() {
            @Override
            public void checkClientTrusted(X509Certificate[] xcs, String string) throws CertificateException {
            }
            @Override
            public void checkServerTrusted(X509Certificate[] xcs, String string) throws CertificateException {
            }
            @Override
            public X509Certificate[] getAcceptedIssuers() {
                return null;
            }
        };
        try {
            sslcontext = SSLContext.getInstance("SSL");
            sslcontext.init(null, new TrustManager[]{tm}, null);
        } catch (NoSuchAlgorithmException e) {
            logger.error("error", e);
        } catch (KeyManagementException e) {
            logger.error("error", e);
        }
    }

}
