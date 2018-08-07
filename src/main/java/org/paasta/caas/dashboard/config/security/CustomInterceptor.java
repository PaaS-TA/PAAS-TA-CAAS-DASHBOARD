package org.paasta.caas.dashboard.config.security;

import org.apache.commons.logging.Log;
import org.paasta.caas.dashboard.common.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;


public class CustomInterceptor extends HandlerInterceptorAdapter {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomInterceptor.class);

    @Autowired
    CommonService commonService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        StringBuffer addParam = new StringBuffer();

        LOGGER.info("### Intercepter start ###");
        LOGGER.info("** Request URI - "+uri);
//        LOGGER.info(request.getParameterMap().toString());

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
        LOGGER.info(" RequestParameter ==>  " + addParam);
        Cookie prevPageCookie = new Cookie("prevPageCookie", uri+addParam);
        response.addCookie(prevPageCookie);


//        if(commonService.isLoginUrl(request)){
//            request.getSession().invalidate();
//            commonService.updateSession();
//        }

//        if (!(url.indexOf("/common") >= 0 ||
//                url.indexOf("/css") >= 0 ||
//                url.indexOf("/webjars") >= 0 ||
//                url.indexOf("/js") >= 0



        if (uri.contains("/dashboard/")) {
            LOGGER.info("** SecurityContextHolder.getContext().getAuthentication().getPrincipal() = "+SecurityContextHolder.getContext().getAuthentication().getPrincipal());
            if (SecurityContextHolder.getContext() != null) {
                try {
                    Cookie cookie0 = WebUtils.getCookie(request, "ssoRefresh");
                    if(cookie0 != null && cookie0.getValue().equals("true")) {
                        Cookie ssoRefreshCookie = new Cookie("ssoRefresh", "false");
                        response.addCookie(ssoRefreshCookie);
                    } else {
                        SecurityContextHolder.clearContext();

                        Cookie ssoRefreshCookie = new Cookie("ssoRefresh", "true");
                        response.addCookie(ssoRefreshCookie);
                        response.sendRedirect(uri+addParam);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/common/error/unauthorized");
                }
            } else {
            }
        } else if(uri.contains("/common/error/unauthorized")) {
            Cookie prevPageCookie2 = new Cookie("prevPageCookie", "");
            response.addCookie(prevPageCookie2);

            Cookie errorRefreshCookie0 = WebUtils.getCookie(request, "errorRefresh");
            if(errorRefreshCookie0 != null && errorRefreshCookie0.getValue().equals("true")) {
                LOGGER.info("error in 1");
                Cookie errorRefreshCookie = new Cookie("errorRefresh", "false");
                response.addCookie(errorRefreshCookie);
            } else {
                LOGGER.info("error in 2");
                SecurityContextHolder.clearContext();

                Cookie errorRefreshCookie = new Cookie("errorRefresh", "true");
                response.addCookie(errorRefreshCookie);
                response.sendRedirect(uri);
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
