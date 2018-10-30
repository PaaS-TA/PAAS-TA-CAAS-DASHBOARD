package org.paasta.caas.dashboard.security;

import org.paasta.caas.dashboard.common.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

/**
 * CustomInterceptor 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
public class SsoAuthenticationFailureHandler implements AuthenticationFailureHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationFailureHandler.class);

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException  {
        LOGGER.info("** onAuthenticationFailure in");
        LOGGER.info("REQUEST URL : "+ request.getRequestURL());

        StringBuffer addParam = new StringBuffer();
        Enumeration<String> paramNames = request.getParameterNames();
        String serviceInstanceId = "";

        int i = 0;
        while (paramNames.hasMoreElements()) {
            String key = paramNames.nextElement();
            String value = request.getParameter(key);

            LOGGER.info("REQUEST PARAM ==>  " + key + " : " + value + "");

            if(key.equals("serviceInstanceId")){
                serviceInstanceId = value;
            }

            if(i == 0) {
                addParam.append("?");
            } else {
                addParam.append("&");
            }
            addParam.append(key+"="+value);
            i++;
        }

        LOGGER.info(Constants.CAAS_INIT_URI+addParam);

        request.getSession().invalidate();
        SecurityContextHolder.clearContext();

        response.sendRedirect(Constants.CAAS_INIT_URI + "/" + serviceInstanceId);

        LOGGER.info("** onAuthenticationFailure out");
    }
}
