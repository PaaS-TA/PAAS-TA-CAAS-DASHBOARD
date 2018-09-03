package org.paasta.caas.dashboard.common;

import javax.servlet.jsp.tagext.SimpleTagSupport;
/**
 * Navigation을 위한 CustomTag 클래스
 *
 * @author hyerin
 * @version 1.0
 * @since 2018.09.03
 */
public class CustomTag extends SimpleTagSupport {

    /**
     * Camel Case로 되어 있는 것을 분리해준다
     * ex) hyerinTest -> Hyerin Test
     * @author hyerin
     * @version 1.0
     * @since 2018.09.03
     */
    public static String camelCaseParser(String str) {
        if(str == null || str.length() == 0) {
            return "";
        }
        String TempStr = "" + str.toUpperCase().charAt(0);
        for(int index = 1; index < str.length(); index++) {

            if(Character.isUpperCase(str.charAt(index))) {
                TempStr += " " + str.charAt(index);
                continue;
            }
            TempStr += str.charAt(index);

        }
        return TempStr;
    }

}