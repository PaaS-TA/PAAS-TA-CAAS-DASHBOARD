package org.paasta.caas.dashboard.role;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Service
public class RoleService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RoleService.class);
    private static final String REQ_URL = "/roles/namespaces/hrjin-namespace/roles";
    private final RestTemplateService restTemplateService;

    @Autowired
    public RoleService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     * Gets role list (모든 네임스페이스에서 조회)
     *
     * @return the role list
     */
    public RoleList getRoleListByAllNamespaces() {
        return restTemplateService.send(Constants.TARGET_CAAS_API,"/roles", HttpMethod.GET, null, RoleList.class);
    }

    /**
     * Gets role list (특정 네임스페이스에서 조회)
     *
     * @return the role list
     */
    public RoleList getRoleList() {
        // url :: /cluster/namespaces/{namespace}/roles
        return restTemplateService.send(Constants.TARGET_CAAS_API,REQ_URL, HttpMethod.GET, null, RoleList.class);
    }

    /**
     * Gets role (특정 네임스페이스에서 조회)
     *
     * @param roleName the role name
     * @return the role
     */
    public Role getRole(String roleName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API,REQ_URL + "/" + roleName, HttpMethod.GET, null, Role.class);
    }
}
