package org.paasta.caas.dashboard.user;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private static final String REQ_URL = "/user";
    private final RestTemplateService restTemplateService;

    @Autowired
    public UserService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    public List<User> getUserList() {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.GET, null, List.class);
    }

}
