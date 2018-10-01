package org.paasta.caas.dashboard.config.security;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.security.SsoAuthenticationDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * CustomInterceptor 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
public class CustomInterceptor extends HandlerInterceptorAdapter {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomInterceptor.class);

    @Autowired
    CommonService commonService;

    @Autowired
    RestTemplateService restTemplateService;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI();

        LOGGER.info("### Intercepter start ###");
        LOGGER.info("** Request URI - "+url);

        try {
            if (!url.contains("/common/error/unauthorized") && !url.contains("/resources/images")) {
                Pattern pattern = Pattern.compile("("+Constants.CAAS_INIT_URI+"/)([a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12})");
                Matcher matcher = pattern.matcher(url);

                SsoAuthenticationDetails ssoAuthenticationDetails = (SsoAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
                if (ssoAuthenticationDetails.getServiceInstanceId() != null && !ssoAuthenticationDetails.getServiceInstanceId().trim().equals("") && ssoAuthenticationDetails.getOrganizationGuid() != null && !ssoAuthenticationDetails.getOrganizationGuid().trim().equals("")) {
                    List commonGetUsers = restTemplateService.send(Constants.TARGET_COMMON_API, "/users/serviceInstanceId/"+ssoAuthenticationDetails.getServiceInstanceId()+"/organizationGuid/"+ssoAuthenticationDetails.getOrganizationGuid(), HttpMethod.GET, null, List.class);

                    if(commonGetUsers == null || commonGetUsers.size() == 0) {
                        LOGGER.info(":: Session not .. redirect.. unauthorized");
                        SecurityContextHolder.clearContext();
                        response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
                        return false;
                    }
                }

                if (url.contains(Constants.CAAS_INIT_URI + "/") && matcher.find()) {
                    try {
                        SecurityContextHolder.clearContext();

                        String serviceInstanceId = request.getServletPath().split("/")[4];

                        response.sendRedirect(Constants.CAAS_INIT_URI + "?serviceInstanceId="+serviceInstanceId);
                        return false;
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
                        return false;
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();

            response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
            return false;
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
