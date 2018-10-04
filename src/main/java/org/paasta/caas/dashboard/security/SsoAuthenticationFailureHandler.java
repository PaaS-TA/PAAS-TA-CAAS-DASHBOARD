package org.paasta.caas.dashboard.security;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.config.security.userdetail.CustomUserDetailsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

public class SsoAuthenticationFailureHandler implements AuthenticationFailureHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationFailureHandler.class);

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException  {
        LOGGER.info("** onAuthenticationFailure in");
        LOGGER.info(request.getRequestURL().toString());

        StringBuffer addParam = new StringBuffer();
        Enumeration<String> paramNames = request.getParameterNames();

        int i = 0;
        while (paramNames.hasMoreElements()) {
            String key = (String) paramNames.nextElement();
            String value = request.getParameter(key);
            LOGGER.info(" RequestParameter Data ==>  " + key + " : " + value + "");
            if(i == 0) {
                addParam.append("?");
            } else {
                addParam.append("&");
            }
            addParam.append(key+"="+value);
            i++;
        }

        LOGGER.info(Constants.CAAS_INIT_URI+addParam);
        String serviceInstanceId = addParam.toString().replace("?serviceInstanceId=", "");
        request.getSession().invalidate();
        SecurityContextHolder.clearContext();
//        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();

//        response.setStatus(200);

//        response.sendRedirect(url+addParam);
//        response.sendRedirect(Constants.CAAS_INIT_URI + "?serviceInstanceId="+serviceInstanceId);
        response.sendRedirect(Constants.CAAS_INIT_URI + "/" + serviceInstanceId);
//        response.sendRedirect("/common/error/unauthorized/serviceInstanceId/"+serviceInstanceId);

        LOGGER.info("** onAuthenticationFailure out");
    }
}
