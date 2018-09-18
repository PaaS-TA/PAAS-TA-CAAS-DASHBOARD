package org.paasta.caas.dashboard.common;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

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
    private final String caasApiBase64Authorization;
    private final String caasCfApiBase64Authorization;
    private final String commonApiBase64Authorization;
    private final RestTemplate restTemplate;
    private String base64Authorization;
    private String baseUrl;

    private final PropertyService propertyService;

    /**
     * Instantiates a new Rest template service.
     *
     * @param restTemplate                   the rest template
     * @param caasApiAuthorizationId         the caas api authorization id
     * @param caasApiAuthorizationPassword   the caas api authorization password
     * @param caasCfApiAuthorizationId       the caas cf api authorization id
     * @param caasCfApiAuthorizationPassword the caas cf api authorization password
     * @param commonApiAuthorizationId       the common api authorization id
     * @param commonApiAuthorizationPassword the common api authorization password
     * @param propertyService                the property service
     */
    @Autowired
    public RestTemplateService(RestTemplate restTemplate,
//                               JpaAdminTokenRepository adminTokenRepository,
                               @Value("${caasApi.authorization.id}") String caasApiAuthorizationId,
                               @Value("${caasApi.authorization.password}") String caasApiAuthorizationPassword,
                               @Value("${caasCfApi.authorization.id}") String caasCfApiAuthorizationId,
                               @Value("${caasCfApi.authorization.password}") String caasCfApiAuthorizationPassword,
                               @Value("${commonApi.authorization.id}") String commonApiAuthorizationId,
                               @Value("${commonApi.authorization.password}") String commonApiAuthorizationPassword,
                               PropertyService propertyService) {
        this.restTemplate = restTemplate;
        this.propertyService = propertyService;
        this.caasApiBase64Authorization = "Basic "
                + Base64Utils.encodeToString(
                (caasApiAuthorizationId + ":" + caasApiAuthorizationPassword).getBytes(StandardCharsets.UTF_8));

        this.caasCfApiBase64Authorization = "Basic "
                + Base64Utils.encodeToString(
                (caasCfApiAuthorizationId + ":" + caasCfApiAuthorizationPassword).getBytes(StandardCharsets.UTF_8));

        this.commonApiBase64Authorization = "Basic "
                + Base64Utils.encodeToString(
                (commonApiAuthorizationId + ":" + commonApiAuthorizationPassword).getBytes(StandardCharsets.UTF_8));

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

        try {
            ResponseEntity<T> resEntity = restTemplate.exchange(baseUrl + reqUrl, httpMethod, reqEntity, responseType);
            if (resEntity.getBody() != null) {
                LOGGER.info("Response Type: {}", resEntity.getBody().getClass());
                LOGGER.info(resEntity.getBody().toString());
            } else {
                LOGGER.info("Response Type: {}", "response body is null");
            }

            return resEntity.getBody();
        } catch (Exception e) {
            e.printStackTrace();

            Map<String, Object> resultMap = new HashMap();
            resultMap.put("resultCode" , "500");
            ObjectMapper mapper = new ObjectMapper();
            LOGGER.info(mapper.convertValue(resultMap, responseType).toString());

            return mapper.convertValue(resultMap, responseType);
        }
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


    private void setApiUrlAuthorization(String reqApi) {

        String apiUrl = "";
        String authorization = "";

        // CAAS API
        if (Constants.TARGET_CAAS_API.equals(reqApi)) {
            apiUrl = propertyService.getCaasApiUrl();
            authorization = caasApiBase64Authorization;
        }

        // CAAS CF API
        if (Constants.TARGET_CAAS_CF_API.equals(reqApi)) {
            apiUrl = propertyService.getCaasCfApiUrl();
            authorization = caasCfApiBase64Authorization;
        }

        // COMMON API
        if (Constants.TARGET_COMMON_API.equals(reqApi)) {
            apiUrl = propertyService.getCommonApiUrl();
            authorization = commonApiBase64Authorization;
        }

        this.base64Authorization = authorization;
        this.baseUrl = apiUrl;
    }
}
