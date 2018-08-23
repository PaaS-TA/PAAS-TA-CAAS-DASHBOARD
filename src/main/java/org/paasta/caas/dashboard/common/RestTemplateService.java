package org.paasta.caas.dashboard.common;

import org.paasta.caas.dashboard.common.repo.JpaAdminTokenRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;
import org.springframework.web.client.RestTemplate;

import javax.transaction.Transactional;
import java.nio.charset.StandardCharsets;

/**
 * Rest Template Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
@Service
public class RestTemplateService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RestTemplateService.class);
    private static final String AUTHORIZATION_HEADER_KEY = "Authorization";
    private static final String CONTENT_TYPE = "Content-Type";
    private final String commonApiBase64Authorization;
    private final String caasApiBase64Authorization;
    private final RestTemplate restTemplate;
    private String base64Authorization;
    private String baseUrl;
    public String caas_adminValue = "";

    private final PropertyService propertyService;

    JpaAdminTokenRepository adminTokenRepository;

    @Value("${caas.admin-token}")
    private String caasAdminToken;


    /**
     * Instantiates a new Rest template service.
     *
     * @param restTemplate                   the rest template
     * @param commonApiAuthorizationId       the common api authorization id
     * @param commonApiAuthorizationPassword the common api authorization password
     * @param caasApiAuthorizationId         the caas api authorization id
     * @param caasApiAuthorizationPassword   the caas api authorization password
     * @param propertyService                the property service
     */
    @Autowired
    public RestTemplateService(RestTemplate restTemplate,
                               JpaAdminTokenRepository adminTokenRepository,
                               @Value("${commonApi.authorization.id}") String commonApiAuthorizationId,
                               @Value("${commonApi.authorization.password}") String commonApiAuthorizationPassword,
                               @Value("${caasApi.authorization.id}") String caasApiAuthorizationId,
                               @Value("${caasApi.authorization.password}") String caasApiAuthorizationPassword, PropertyService propertyService) {
        this.restTemplate = restTemplate;
        this.adminTokenRepository = adminTokenRepository;
        this.propertyService = propertyService;

        this.commonApiBase64Authorization = "Basic "
                + Base64Utils.encodeToString(
                (commonApiAuthorizationId + ":" + commonApiAuthorizationPassword).getBytes(StandardCharsets.UTF_8));
        this.caasApiBase64Authorization = "Basic "
                + Base64Utils.encodeToString(
                (caasApiAuthorizationId + ":" + caasApiAuthorizationPassword).getBytes(StandardCharsets.UTF_8));
    }


    /**
     * Send t.
     *
     * @param <T>          the type parameter
     * @param reqApi       the req api
     * @param reqUrl       the req url
     * @param httpMethod   the http method
     * @param bodyObject   the body object
     * @param responseType the response type
     * @return the t
     */
    public <T> T send(String reqApi, String reqUrl, HttpMethod httpMethod, Object bodyObject, Class<T> responseType) {

        setApiUrlAuthorization(reqApi);

        HttpHeaders reqHeaders = new HttpHeaders();
        reqHeaders.add(AUTHORIZATION_HEADER_KEY, base64Authorization);
        reqHeaders.add(CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);

        HttpEntity<Object> reqEntity = new HttpEntity<>(bodyObject, reqHeaders);

        LOGGER.info("<T> T send :: Request : {} {baseUrl} : {}, Content-Type: {}", httpMethod, reqUrl, reqHeaders.get(CONTENT_TYPE));
        ResponseEntity<T> resEntity = restTemplate.exchange(baseUrl + reqUrl, httpMethod, reqEntity, responseType);
        if (resEntity.getBody() != null) {
            LOGGER.info("Response Type: {}", resEntity.getBody().getClass());
        } else {
            LOGGER.info("Response Type: {}", "response body is null");
        }


        return resEntity.getBody();
    }

    /**
     * Cf send t.
     *
     * @param <T>          the type parameter
     * @param reqToken     the req token
     * @param reqUrl       the req url
     * @param httpMethod   the http method
     * @param bodyObject   the body object
     * @param responseType the response type
     * @return the t
     */
    public <T> T cfSend(String reqToken, String reqUrl, HttpMethod httpMethod, Object bodyObject, Class<T> responseType) {

        HttpHeaders reqHeaders = new HttpHeaders();
        reqHeaders.add(AUTHORIZATION_HEADER_KEY, "bearer " + reqToken);
        reqHeaders.add(CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);

        HttpEntity<Object> reqEntity = new HttpEntity<>(bodyObject, reqHeaders);

        LOGGER.info("<T> T send :: Request : {} {baseUrl} : {}, Content-Type: {}", httpMethod, reqUrl, reqHeaders.get(CONTENT_TYPE));
        ResponseEntity<T> resEntity = restTemplate.exchange(reqUrl, httpMethod, reqEntity, responseType);
        if (resEntity.getBody() != null) {
            LOGGER.info("Response Type: {}", resEntity.getBody().getClass());
        } else {
            LOGGER.info("Response Type: {}", "response body is null");
        }


        return resEntity.getBody();
    }

    public <T> T cubeSend(String url, HttpMethod httpMethod, Class<T> responseType) {
        return cubeSend(url, null, httpMethod, responseType);
    }

    /**
     * kuber api와 통신하기 위한 메소드
     * get의 경우 body가 필요 없기 때문에 yml로 get,delete의 유무판별하여 body를 넣고 안넣고를 정함.
     * @author Hyerin
     * @since 2018.08.22
     */
    @Transactional
    public <T> T cubeSend(String url, String yml, HttpMethod httpMethod, Class<T> responseType) {
        LOGGER.info("cubeSend start~");
        try {
            if(caas_adminValue.equals("")) {
                caas_adminValue = adminTokenRepository.getOne(caasAdminToken).getTokenValue();
            }
            LOGGER.info(caas_adminValue);
        } catch (Exception e) {
            e.printStackTrace();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + caas_adminValue);
        headers.add("Accept", "application/json,application/yaml,text/html");
        headers.add("Content-Type", "application/yaml;charset=UTF-8");


        HttpEntity<String> reqEntity;
        if(yml == null) {  //null이면
            reqEntity = new HttpEntity<>(headers);
        } else { // null이 아니면
            reqEntity = new HttpEntity<>(yml, headers);
        }
        ResponseEntity<T> resEntity = restTemplate.exchange(url, httpMethod, reqEntity, responseType);
        if (reqEntity.getBody() != null) {
            LOGGER.info("Response Type: {}", resEntity.getBody().getClass());
        }

        return resEntity.getBody();
    }

    private void setApiUrlAuthorization(String reqApi) {

        String apiUrl = "";
        String authorization = "";

        // COMMON API
        if (Constants.TARGET_COMMON_API.equals(reqApi)) {
            apiUrl = propertyService.getCommonApiUrl();
            authorization = commonApiBase64Authorization;
        }

        // CAAS API
        if (Constants.TARGET_CAAS_API.equals(reqApi)) {
            apiUrl = propertyService.getCaasApiUrl();
            authorization = caasApiBase64Authorization;
        }

        this.base64Authorization = authorization;
        this.baseUrl = apiUrl;
    }
}
