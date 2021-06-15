package utils;

public class CommonUtils {

    public static String fillStringBeforeString(String str ,String fill, int length) {
         if(str.length() < length) {
             StringBuilder sb = new StringBuilder();
             for(int i = 0; i < length - str.length() ; i++) {
             sb.append(fill);
             }
           sb.append(str);
           return sb.toString();
        }else {
           return str;
        }
    }
    //字段补位，str是需补位的字符串，fill是填补的字符串，length是指定的位数
    public static String fillZeroBeforeString(String str , int length) {
         return fillStringBeforeString(str,"0",length);
    }

}
