package org.paasta.caas.dashboard.config.security;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.config.security.userdetail.CustomUserDetailsService;
import org.paasta.caas.dashboard.security.SsoAuthenticationDetails;
import org.paasta.caas.dashboard.users.UsersList;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
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

    @Autowired
    CustomUserDetailsService customUserDetailsService;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI();

        LOGGER.info("### Intercepter start ###");
        LOGGER.info("** Request URI - "+url);

        try {

            if (!url.contains("/common/error/unauthorized") && !url.contains("/resources")) {
                Pattern pattern = Pattern.compile("("+Constants.CAAS_INIT_URI+"/)([a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12})");
                Matcher matcher = pattern.matcher(url);

                SsoAuthenticationDetails ssoAuthenticationDetails = null;

                Object obj = SecurityContextHolder.getContext().getAuthentication().getDetails();

                if( obj instanceof SsoAuthenticationDetails){
                    ssoAuthenticationDetails = (SsoAuthenticationDetails) obj ;
                }

                if (ssoAuthenticationDetails != null && !ssoAuthenticationDetails.getNameSpace().isEmpty()) {

                    LOGGER.info(":: ssoAuthenticationDetails.namespace ::"+ ssoAuthenticationDetails.getNameSpace());

                    // ADD: namespace exist checked by user
                    boolean isExistNamespace = restTemplateService.send(Constants.TARGET_COMMON_API, Constants.URI_COMMON_API_USERS_VALID_EXIST_NAMESPACE
                            .replace("{userId}", ssoAuthenticationDetails.getUserid())
                            .replace("{namespace}", ssoAuthenticationDetails.getNameSpace())
                            , HttpMethod.GET, null, Boolean.class);

                    if(!isExistNamespace){
                        LOGGER.info("### Namespace not exist.[{}] plz Check the namespace. ###", ssoAuthenticationDetails.getNameSpace());
                        SecurityContextHolder.clearContext();

                        // rest api 경우 error 처리
                        if(url.indexOf("/api/") == 0){
                            response.resetBuffer();
                            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                            response.flushBuffer();
                        }else{
                            response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
                        }
                    }

                }else{
                    // 최초 접속이 아니면서 SSO 데이터가 없는 경우 Redirect 처리
                    if(!url.contains("/caas/intro/overview/") && ssoAuthenticationDetails == null){

                        // rest api 경우 error 처리
                        if(url.indexOf("/api/") == 0) {
                            response.resetBuffer();
                            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                            response.flushBuffer();
                        }else {
                            LOGGER.info("### ssoAuthenticationDetails info is null. ###");
                            SecurityContextHolder.clearContext();
                            response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
                        }
                    }

                }


                // 최초 접속시.
                if (url.contains(Constants.CAAS_INIT_URI + "/") && matcher.find()) {
                    try {
                        String serviceInstanceId = request.getServletPath().split("/")[4];

                        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

                        if (authentication != null) {
                            //SsoAuthenticationDetails ssoAuthenticationDetails = (SsoAuthenticationDetails) authentication.getDetails();
                            ssoAuthenticationDetails = (SsoAuthenticationDetails) authentication.getDetails();

//                            String aa = customUserDetailsService.getUaaToken(true);
//                            LOGGER.info(aa);

//                            String ssoServiceInstanceId = ssoAuthenticationDetails.getServiceInstanceId();
                            String uaaToken = ssoAuthenticationDetails.getAccessToken().toString();
                            LOGGER.info(uaaToken);

                            if (!customUserDetailsService.isManagingApp(uaaToken, serviceInstanceId)) {
                                LOGGER.info("==== 1");
                                SecurityContextHolder.clearContext();
                                response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
                                return false;
                            }
                        } else {
                            LOGGER.info("==== 2");
                            LOGGER.info(":: Session not .. redirect.. unauthorized.");
                            SecurityContextHolder.clearContext();
                            response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
                            return false;
                        }

                        SecurityContextHolder.clearContext();
                        LOGGER.info(url+" ==== 0");
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
