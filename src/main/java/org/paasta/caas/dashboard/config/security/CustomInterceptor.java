package org.paasta.caas.dashboard.config.security;

import org.paasta.caas.dashboard.common.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        Pattern pattern = Pattern.compile("(/caas/cluster/overview/)([a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12})");
        Matcher matcher = pattern.matcher(url);

        if (url.contains("/caas/cluster/overview/") && matcher.find()) {
            try {
                SecurityContextHolder.clearContext();

                String serviceInstanceId = request.getServletPath().split("/")[4];

                addParam = new StringBuffer();
                addParam.append("?serviceInstanceId="+serviceInstanceId);
                response.sendRedirect("/caas/cluster/overview"+addParam);
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
