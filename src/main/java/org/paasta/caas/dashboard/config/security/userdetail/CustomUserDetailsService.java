package org.paasta.caas.dashboard.config.security.userdetail;

//import org.openpaas.paasta.portal.web.user.service.CommonService;
import org.paasta.caas.dashboard.cf.CfService;
import org.paasta.caas.dashboard.security.SsoAuthenticationDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class CustomUserDetailsService implements UserDetailsService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CustomUserDetailsService.class);


//    @Autowired
//    private CommonService commonService;

    @Autowired
    private CfService cfService;


    private String token;

    public void setToken(String token){
        this.token = token;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        Map result = null;
//        Map restUserInfo = null;
//        boolean userVerification = true;
//        try{
//            result = commonService.procRestTemplate("/user/getUser/"+username+"/", HttpMethod.GET, null, "");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        List role = new ArrayList();
//
//        if (!result.containsKey("User")) {
//            userVerification = false;
//            insertUser(username);
//        }else{
//            restUserInfo = (Map) result.get("User");
//            if(restUserInfo == null){
//                userVerification = false;
//                insertUser(username);
//            }
//        }
//        String adminYn;
//        String imgPath;
//        if(!userVerification) {
//             adminYn = "Y";
//             imgPath = null;
//        }else{
//            adminYn = (String) restUserInfo.get("adminYn");
//            imgPath = (String) restUserInfo.get("imgPath");
//        }
//
//
//        if (adminYn.equalsIgnoreCase("Y"))
//            role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
//        else
//            role.add(new SimpleGrantedAuthority("ROLE_USER"));
        LOGGER.info("name : "+username);
        if(username.equals("demo")) {
            role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else {
            role.add(new SimpleGrantedAuthority("ROLE_USER"));
        }
//        role.add(new SimpleGrantedAuthority("ROLE_USER"));

        User user = new User(username, "N/A", role);
//        user.setImgPath(imgPath);
        return user;
    }

    public UserDetails loadUserBySsoAuthenticationDetails(SsoAuthenticationDetails ssoAuthenticationDetails) {
        List role = new ArrayList();

        LOGGER.info("username : "+ssoAuthenticationDetails.getUserid());
        LOGGER.info("uaaid : "+ssoAuthenticationDetails.getId());
        LOGGER.info("token : "+ssoAuthenticationDetails.getAccessToken());
        LOGGER.info("Instance id : "+ssoAuthenticationDetails.getManagingServiceInstance());

        String username = ssoAuthenticationDetails.getUserid();
        String uaaid = ssoAuthenticationDetails.getId();
        String token = ssoAuthenticationDetails.getAccessToken().toString();
        String instanceId = ssoAuthenticationDetails.getManagingServiceInstance();

        Map cfResult = cfService.getCfOrgsByUaaIdAndToken(uaaid, token);
        LOGGER.info(cfResult.toString());

        if(instanceId.equals("28135c3e-95b8-4fb2-bf57-2084e8db939a")) {
            role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else {
            role.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        User user = new User(username, "N/A", role);
        user.setServiceInstanceId(ssoAuthenticationDetails.getManagingServiceInstance());
        return user;
    }


}
