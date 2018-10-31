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
import org.springframework.http.HttpMethod;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

    /**
     * preHandle 구현
     * 최초 접속시 redirect 및 namespace 체크
     *
     * @param request    HttpServletRequest
     * @param response   HttpServletResponse
     * @param handler    Object
     * @return boolean
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI();
        String ajaxHeader = request.getHeader("X-CaaS-Ajax-call"); // Ajax Call header value

        LOGGER.info("### Interceptor start ###");
        LOGGER.info("** Request URI - "+url);

        try {
            if (!url.contains("/common/error/unauthorized") && !url.contains("/resources")) {

                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                SsoAuthenticationDetails ssoAuthenticationDetails = null;
                String serviceInstanceId = "";
                Pattern pattern = Pattern.compile("("+Constants.CAAS_INIT_URI+"/)([a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12})");
                Matcher matcher = pattern.matcher(url);
                boolean isInitUrl      = url.contains(Constants.CAAS_INIT_URI + "/") && matcher.find(); // 초기화 URL 여부
                boolean isUnauthorized = false; // author 참조 에러 : true  정상 : false

                try {

                    // Default. 권한 정보 체크
                    if (authentication != null) {
                        ssoAuthenticationDetails = (SsoAuthenticationDetails) authentication.getDetails();
                    } else { // authentication == null
                        LOGGER.error("== authentication info is null.");
                        isUnauthorized = true; // authentication 정보 없음
                    }

                    // A. 인스턴스 ID를 가지고 최초 진입 페이지 접근시, 권한 참고 오류 처리
                    if(isInitUrl){

                        // A-1. 권한 정보 정상일시 처리
                        if(!isUnauthorized){

                            serviceInstanceId = request.getServletPath().split("/")[4];
                            String uaaToken   = ssoAuthenticationDetails.getAccessToken().toString();
                            LOGGER.info("uaaToken : {}", uaaToken);

                            // A-2. 사용자가 현재 서비스 인스턴스를 관리 할 수 ​​있는지 여부를 확인
                            if (!customUserDetailsService.isManagingApp(uaaToken, serviceInstanceId)) {
                                LOGGER.error("== This user do not manage that serviceInstance.");
                                isUnauthorized = true;
                            }

                        } // End isUnauthorized.

                        SecurityContextHolder.clearContext();

                    }else{
                        // B. 요청마다 Namespace 존재 여부(DB)를 체크한다.  By ssoAuthenticationDetails
                        LOGGER.info(":: ssoAuthenticationDetails.namespace ::"+ ssoAuthenticationDetails.getNameSpace());

                        boolean isExistNamespace = restTemplateService.send(Constants.TARGET_COMMON_API
                                , Constants.URI_COMMON_API_USERS_VALID_EXIST_NAMESPACE
                                        .replace("{userId}", ssoAuthenticationDetails.getUserId())
                                        .replace("{namespace}", ssoAuthenticationDetails.getNameSpace())
                                , HttpMethod.GET, null, Boolean.class);

                        if(!isExistNamespace) { // Namespace 가 존재하지 않을시
                            LOGGER.info("### Namespace not exist.[{}] please Check the namespace. ###"
                                    , ssoAuthenticationDetails.getNameSpace());
                            isUnauthorized = true;
                        }

                    }

                    // C. A/B의 isUnauthorized 분기 처리
                    if(isUnauthorized){ // 권한 참고 실패

                        LOGGER.info(url+" == Author check is Failure.");

                        if(ajaxHeader == null) { // Ajax call 외에는 redirect 처리
                            response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
                        }else{ // Ajax call 일시 errorCode 전송

                            if("true".equals(ajaxHeader)){ // header value check
                                response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                            }else{
                                response.sendError(HttpServletResponse.SC_UNAUTHORIZED
                                        , "Header value 'X-CaaS-Ajax-call' is mismatch.");
                            }
                        }

                    }else{ // 정상 처리
                        LOGGER.info(url+" == Author check is Passed.");

                        if(isInitUrl){ // 최초 접속 일시 redirect 처리
                            response.sendRedirect(Constants.CAAS_INIT_URI + "?serviceInstanceId="+serviceInstanceId);
                        }else{ // 그외 핸들링 처리 없음

                        }
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath()+"/common/error/unauthorized");
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
