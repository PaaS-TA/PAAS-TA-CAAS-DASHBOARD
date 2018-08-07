package org.paasta.caas.dashboard.common;

import org.paasta.caas.dashboard.config.security.SsoSecurityConfiguration;
import org.paasta.caas.dashboard.config.security.userdetail.CustomUserDetailsService;
import org.paasta.caas.dashboard.config.security.userdetail.User;
import org.paasta.caas.dashboard.security.SsoAuthenticationDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.resource.OAuth2ProtectedResourceDetails;
import org.springframework.security.oauth2.client.token.AccessTokenRequest;
import org.springframework.security.oauth2.client.token.DefaultAccessTokenRequest;
import org.springframework.security.oauth2.client.token.grant.password.ResourceOwnerPasswordAccessTokenProvider;
import org.springframework.security.oauth2.client.token.grant.password.ResourceOwnerPasswordResourceDetails;
import org.springframework.security.oauth2.common.AuthenticationScheme;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by indra on 2018-08-02.
 */
@Service
public class CommonService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CommonService.class);
//    private final InstanceUseService instanceUseService;
//    private final AuthorityService authorityService;

    private final CustomUserDetailsService customUserDetailsService;


    @Value("${cf.uaa.oauth.client.id}")
    private String clientId;

    @Value("${cf.uaa.oauth.client.secret}")
    private String clientSecret;

    @Value("${cf.uaa.oauth.info.uri}")
    private String oauthInfoUrl;

//    @Value("${cf.api.url}")
    private String apiUrl = "";

    @Value("${cf.uaa.oauth.token.check.uri}")
    private String checkTokenUri;

    @Value("${cf.uaa.oauth.authorization.uri}")
    private String authorizationUri;

    @Value("${cf.uaa.oauth.token.access.uri}")
    private String accessUri;

    @Value("${cf.uaa.oauth.logout.url}")
    private String logoutUrl;


//    @Autowired
//    public CommonService(InstanceUseService instanceUseService, AuthorityService authorityService) {
//        this.instanceUseService = instanceUseService;
//        this.authorityService = authorityService;
//    }
    @Autowired
    public CommonService(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }


    public static int diffDay(Date d, Date accessDate) {
        Calendar curC = Calendar.getInstance();
        Calendar accessC = Calendar.getInstance();
        curC.setTime(d);
        accessC.setTime(accessDate);
        accessC.compareTo(curC);
        int diffCnt = 0;
        while (!accessC.after(curC)) {
            diffCnt++;
            accessC.add(Calendar.DATE, 1); // 다음날로 바뀜
        }
//        System.out.println("기준일로부터 " + diffCnt + "일이 지났습니다.");
//        System.out.println(accessC.compareTo(curC));
        return diffCnt;
    }


    /**
     * Sets path variables.
     *
     * @param httpServletRequest the http servlet request
     * @param viewName           the view name
     * @param mv                 the mv
     * @return the path variables
     */
    public ModelAndView setPathVariables(HttpServletRequest httpServletRequest, String viewName, ModelAndView mv) {
        Map pathVariablesMap = (Map) httpServletRequest.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
        Object pathVariablesObject;
        String pathVariablesKey;

        Map<String, String[]> parametersMap = httpServletRequest.getParameterMap();
        String[] parametersObject;
        String parametersKey;

        for (int i = 0; i < PathVariablesList.values().length; i++) {
            pathVariablesKey = PathVariablesList.values()[i].actualValue;
            pathVariablesObject = pathVariablesMap.get(pathVariablesKey);

            if (pathVariablesObject != null) {
                mv.addObject(pathVariablesKey, String.valueOf(pathVariablesObject));
            }
        }

        for (int i = 0; i < ParametersList.values().length; i++) {
            parametersKey = ParametersList.values()[i].actualValue;
            parametersObject = parametersMap.get(parametersKey);

            if (parametersObject != null && !"".equals(parametersObject[0])) {
                mv.addObject(parametersKey, parametersObject[0]);
            }
        }

        mv.setViewName(viewName);

        LOGGER.info("ModelAndView :: {}", mv);

        return mv;
    }


    /**
     * Sets parameters.
     *
     * @param httpServletRequest the http servlet request
     * @return the parameters
     */
    public String setParameters(HttpServletRequest httpServletRequest) {
        Map<String, String[]> parametersMap = httpServletRequest.getParameterMap();
        String[] parametersObject;
        String parametersKey;
        String resultString = "";

        StringBuilder stringBuilder = new StringBuilder();

        for (int i = 0; i < ParametersList.values().length; i++) {
            parametersKey = ParametersList.values()[i].actualValue;
            parametersObject = parametersMap.get(parametersKey);

            if (parametersObject != null && !"".equals(parametersObject[0])) {
                stringBuilder.append("&").append(parametersKey).append("=").append(parametersObject[0]);
            }
        }

        if (stringBuilder.length() > 0) {
            resultString = "?" + stringBuilder.substring(1);
        }

        return resultString;
    }


    /**
     * Gets user info.
     *
     * @return the user info
     */
    public SsoAuthenticationDetails getUserInfo() {

        return (SsoAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
    }


    /**
     * Gets user id.
     *
     * @return the user id
     */
    public String getUserId() {
        return SecurityContextHolder.getContext().getAuthentication().getName();
    }


    /**
     * Update session.
     */
    public void updateSession() {
//        List<GrantedAuthority> role = new ArrayList();
        List authorities = new ArrayList();

        Collection<? extends GrantedAuthority> role = null;
        User user = null;


        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null) {
            String name = authentication.getName();
            try {
                SsoAuthenticationDetails ssoAuthenticationDetails = (SsoAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();

                LOGGER.info("###############################################################");
                LOGGER.info("SESSION INFOMATION UPDATE [" + name + "]" + " [" + ssoAuthenticationDetails.getUserid() + "]" + " [" + authentication.getPrincipal() + "] ");
                LOGGER.info("###############################################################");

//                final Object details = authentication.getDetails();
//                if (!(details instanceof SsoAuthenticationDetails)) {
//                    throw new InternalAuthenticationServiceException("The authentication details [" + details
//                            + "] are not an instance of " + SsoAuthenticationDetails.class.getSimpleName());
//                }

//                SecurityContextHolder.clearContext();

//                if (!isManagingApp(ssoAuthenticationDetails.getManagingServiceInstance())) {
//                    SecurityContextHolder.clearContext();
//                    throw new AccessDeniedException("Permission Error on [" + name + "]");
//                }


                //권한들에 대한 정보 추출
//                List<Map> pipeauthorities = authorityService.getAuthorityListMap();
//
//                String adminRoleId = "";
//                String adminRoleDisplayName = "";
//                String userRoleId = "";
//                String userRoleDisplayName = "";
//
//
//                for (int i = 0; i < pipeauthorities.size(); i++) {
//                    if (pipeauthorities.get(i).get("code") != null) {
//                        String code = pipeauthorities.get(i).get("code").toString();
//                        if (code.equalsIgnoreCase("dashboard.manager")) {
//                            adminRoleId = pipeauthorities.get(i).get("id").toString();
//                            adminRoleDisplayName = pipeauthorities.get(i).get("displayName").toString();
//                        } else if (code.equalsIgnoreCase("dashboard.user")) {
//                            userRoleId = pipeauthorities.get(i).get("id").toString();
//                            userRoleDisplayName = pipeauthorities.get(i).get("displayName").toString();
//                        }
//                    }
//                }
//
//
//                InstanceUse instanceUse = instanceUseService.getInstanceUse(dashboardAuthenticationDetails.getManagingServiceInstance(), dashboardAuthenticationDetails.getId());
//
//
//                if (instanceUse != null) {
//                    if (instanceUse.getGrantedAuthorities() != null) {
//                        for (GrantedAuthority grantedAuthority : instanceUse.getGrantedAuthorities()) {
//                            role.add(grantedAuthority);
//                        }
//                    }
//                }
//
//                //권한이 있으면...ID값으로 권한을 검색해서...사용자?? 관리자?? 권한 부여...
//                if (role.size() > 0) {
//                    ssoAuthenticationDetails.setGrantedAuthorities(role);
//                    for (int i = 0; i < role.size(); i++) {
//                        if (role.get(i).getId() != null) {
//                            if (role.get(i).getAuthority().getId().equalsIgnoreCase(adminRoleId)) {
//                                ssoAuthenticationDetails = setDetails(ssoAuthenticationDetails, "ROLE_ADMIN", adminRoleId, adminRoleDisplayName);
//                            } else if (role.get(i).getAuthority().getId().equalsIgnoreCase(userRoleId)) {
//                                ssoAuthenticationDetails = setDetails(ssoAuthenticationDetails, "ROLE_USER", userRoleId, userRoleDisplayName);
//                            }
//                        }
//                    }
//                }
//
//
                authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(authentication.getPrincipal(), "N/A", authorities));
//
//
//                //이렇게 까지 했는데...없으면...에러 출력
//                if (ssoAuthenticationDetails.getRoleId() == null) {
//                    throw new AccessDeniedException("Permission Error on [" + name + "]");
//                }
LOGGER.info("====================================================================================="+ssoAuthenticationDetails.getUserid());


                customUserDetailsService.setToken(ssoAuthenticationDetails.getAccessToken().getValue());
                user = (User) customUserDetailsService.loadUserByUsername(ssoAuthenticationDetails.getUserid());
                role = user.getAuthorities();

                ssoAuthenticationDetails.setUsername(user.getUsername());
                ssoAuthenticationDetails.setImgPath(user.getImgPath());

                //이상없으면 세션에 저장
//                authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(ssoAuthenticationDetails.getUserid(), "N/A", role));
                authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(authentication.getPrincipal(), "N/A", authorities));
//                authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(authentication.getPrincipal(), "N/A", role));
                ((OAuth2Authentication) authentication).setDetails(ssoAuthenticationDetails);


//                SecurityContextHolder.getContext().setAuthentication(authentication);
                printSessionInfo(ssoAuthenticationDetails);

            } catch (Exception e) {
                e.printStackTrace();
                // 세션 초기화
                ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
                throw new InternalAuthenticationServiceException("Permission Error on [" + name + "]", e);

            }
        } else {
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            throw new InternalAuthenticationServiceException("Access Denied");
        }
    }

    private void printSessionInfo(SsoAuthenticationDetails ssoAuthenticationDetails) {
        LOGGER.info("####################################################################");
        LOGGER.info(ssoAuthenticationDetails.getSessionId());
        LOGGER.info(ssoAuthenticationDetails.getId());
        LOGGER.info(ssoAuthenticationDetails.getUserid());
        LOGGER.info("####################################################################");
    }


    /**
     * Sets details.
     *
     * @param ssoAuthenticationDetails the dashboard authentication details
     * @param roleString                     the role string
     * @param roleId                         the role id
     * @param roleDisplayName                the role display name
     * @return the details
     */
    public SsoAuthenticationDetails setDetails(SsoAuthenticationDetails ssoAuthenticationDetails, String roleString, String roleId, String roleDisplayName) {
        ssoAuthenticationDetails.setRole(roleString);
        ssoAuthenticationDetails.setRoleId(roleId);
        ssoAuthenticationDetails.setRoleDisplayName(roleDisplayName);
        return ssoAuthenticationDetails;
    }


    /**
     * Gets token.
     *
     * @return the token
     */
    public String getToken() {
        SsoAuthenticationDetails user = ((SsoAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails());
        LOGGER.info("############################# Token Expired : " + (user.getAccessToken().getExpiration().getTime() - System.currentTimeMillis()) / 1000 + " sec");
        // Token 만료 시간 비교
        if (user.getAccessToken().getExpiration().getTime() <= System.currentTimeMillis()) {
            //Rest 생성
            RestTemplate rest = new RestTemplate();
            //Token 재요청을 위한 데이터 설정
            OAuth2ProtectedResourceDetails resource = getResourceDetails(user.getUserid(), "N/A", clientId, clientSecret, accessUri);
            AccessTokenRequest accessTokenRequest = new DefaultAccessTokenRequest();
            ResourceOwnerPasswordAccessTokenProvider provider = new ResourceOwnerPasswordAccessTokenProvider();
            provider.setRequestFactory(rest.getRequestFactory());
            //Token 재요청
            OAuth2AccessToken refreshToken = provider.refreshAccessToken(resource, user.getAccessToken().getRefreshToken(), accessTokenRequest);


            //재요청으로 받은 Token 재설정
            user.setAccessToken(refreshToken);
            // session에 적용
            Authentication authentication = new UsernamePasswordAuthenticationToken(SecurityContextHolder.getContext().getAuthentication(), "N/A", SecurityContextHolder.getContext().getAuthentication().getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        String token = user.getTokenValue();

        return token;
    }


    private OAuth2ProtectedResourceDetails getResourceDetails(String username, String password, String clientId, String clientSecret, String url) {
        ResourceOwnerPasswordResourceDetails resource = new ResourceOwnerPasswordResourceDetails();
        resource.setUsername(username);
        resource.setPassword(password);
        resource.setClientId(clientId);
        resource.setClientSecret(clientSecret);
        resource.setId(clientId);
        resource.setClientAuthenticationScheme(AuthenticationScheme.header);
        resource.setAccessTokenUri(url);

        return resource;
    }

    public static final String MANAGED_KEY = "manage";

    /**
     * Checks whether the user is allowed to manage the current service instance.
     */
    private boolean isManagingApp(String serviceInstanceId) {
        final String url = getCheckUrl(serviceInstanceId);

        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "Bearer " + getToken());
            HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);

            ResponseEntity<Map> result = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
            Map body = result.getBody();

            return Boolean.TRUE.toString().equals(body.get(MANAGED_KEY).toString().toLowerCase());
        } catch (RestClientException e) {
            e.printStackTrace();
            LOGGER.error("Error while retrieving authorization from [" + url + "].", e);
            return false;
        }
    }


    public static final String TOKEN_SUID = "[SUID]";

    private String getCheckUrl(String serviceInstanceId) {
        return apiUrl.replace(TOKEN_SUID, serviceInstanceId);
    }


    public boolean isLoginUrl(HttpServletRequest request) {
        boolean logoutPlay = false;
        boolean allowedrange = false;
        String url = request.getRequestURI();
        LOGGER.info("#######################################################");
        LOGGER.info("#######################################################");
        LOGGER.info("REQUEST URL : " + url);
        LOGGER.info("#######################################################");
        LOGGER.info("#######################################################");
        try {
            String urls[] = url.split("/");
            if (urls != null) {
                if (urls.length == 3 || urls.length == 4) {
                    if (urls.length == 4) {
                        if (urls[3].length() == 0) {
                            allowedrange = true;
                        }
                    }

                    if (urls.length == 3) {
                        allowedrange = true;
                    }
                    if (allowedrange) {
                        if (urls[1].indexOf("dashboard") >= 0) {
                            return true;
                        }
                    }
                }
            }
            return false;
        } catch (Exception e) {
            return false;
        }

    }


    /**
     * The enum Path variables list.
     */
    enum PathVariablesList {
        /**
         * Path variables su id path variables list.
         */
        PATH_VARIABLES_SU_ID("suid"),
        /**
         * Path variables service instance id path variables list.
         */
        PATH_VARIABLES_SERVICE_INSTANCE_ID("serviceInstancesId"),
        /**
         * Path variables pipeline id path variables list.
         */
        PATH_VARIABLES_PIPELINE_ID("pipelineId"),
        /**
         * Path variables job type path variables list.
         */
        PATH_VARIABLES_JOB_TYPE("jobType"),
        /**
         * Path variables job history id path variables list.
         */
        PATH_VARIABLES_JOB_HISTORY_ID("jobHistoryId"),
        /**
         * Path variables id path variables list.
         */
        PATH_VARIABLES_ID("id");

        private String actualValue;

        PathVariablesList(String actualValue) {
            this.actualValue = actualValue;
        }
    }


    /**
     * The enum Parameters list.
     */
    enum ParametersList {
        /**
         * Parameters id parameters list.
         */
        PARAMETERS_ID("id"),
        /**
         * Parameters name parameters list.
         */
        PARAMETERS_NAME("name"),
        /**
         * Parameters page parameters list.
         */
        PARAMETERS_PAGE("page"),
        /**
         * Parameters size parameters list.
         */
        PARAMETERS_SIZE("size"),
        /**
         * Parameters sort parameters list.
         */
        PARAMETERS_SORT("sort"),
        /**
         * Parameters job type parameters list.
         */
        PARAMETERS_JOB_TYPE("jobType"),
        /**
         * Parameters group order parameters list.
         */
        PARAMETERS_GROUP_ORDER("groupOrder"),
        /**
         * Parameters job order parameters list.
         */
        PARAMETERS_JOB_ORDER("jobOrder"),
        /**
         * Parameters auth type parameters list.
         */
        PARAMETERS_AUTH_TYPE("authName"),
        /**
         * Parameters cf name parameters list.
         */
        PARAMETERS_CF_NAME("cfName");

        private String actualValue;

        ParametersList(String actualValue) {
            this.actualValue = actualValue;
        }
    }
}
