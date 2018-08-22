package org.paasta.caas.dashboard.config.security;

import org.apache.commons.logging.Log;
import org.paasta.caas.dashboard.common.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class CustomInterceptor extends HandlerInterceptorAdapter {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomInterceptor.class);

    @Autowired
    CommonService commonService;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI();
        StringBuffer addParam = new StringBuffer();

        LOGGER.info("### Intercepter start ###");
        LOGGER.info("** Request URI - "+url);

//        Enumeration<String> paramNames = request.getParameterNames();
//        int i = 0;
//        while (paramNames.hasMoreElements()) {
//            String key = (String) paramNames.nextElement();
//            String value = request.getParameter(key);
//            LOGGER.info(" RequestParameter Data ==>  " + key + " : " + value + "");
//                if(i == 0) {
//                    addParam.append("?");
//                } else {
//                    addParam.append("&");
//                }
//                addParam.append(key+"="+value);
//                i++;
//        }

        Pattern pattern = Pattern.compile("(/caas/dashboard/)([a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12})");
        Matcher matcher = pattern.matcher(url);

        if (url.contains("/caas/dashboard/") && matcher.find()) {
            try {
                SecurityContextHolder.clearContext();

                String serviceInstanceId = request.getServletPath().split("/")[3];

                addParam = new StringBuffer();
                addParam.append("?serviceInstanceId="+serviceInstanceId);
                response.sendRedirect("/caas/dashboard/"+addParam);
                return false;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/common/error/unauthorized");
            }
        }

        LOGGER.info("### Intercepter end ###");
        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }

}
