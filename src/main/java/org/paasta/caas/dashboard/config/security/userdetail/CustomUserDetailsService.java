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

        String username = ssoAuthenticationDetails.getUserid();
        String uaaid = ssoAuthenticationDetails.getId();
        String token = ssoAuthenticationDetails.getAccessToken().toString();

        Map cfResult = cfService.getCfOrgsByUaaIdAndToken(uaaid, token);
        LOGGER.info(cfResult.toString());

        if(username.equals("demo")) {
            role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else {
            role.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        User user = new User(username, "N/A", role);
        return user;
    }


    private void insertUser(String username){
//        LOGGER.info("insertUser Start : " + username);
//        Map user = new HashMap();
//        user.put("userId" , username);
//        user.put("userName" , username);
//        user.put("status" , "1");
//        user.put("tellPhone" ,null);
//        user.put("zipCode" , null);
//        user.put("address" , null);
//        user.put("addressDetail" , null);
//        user.put("adminYn" , "Y");
//        user.put("imgPath" , null);
//        ResponseEntity rssResponse = commonService.procRestTemplate("/user/insertUser", HttpMethod.POST, user, token, String.class);
//        LOGGER.info("insertUser End ");
    }

//    public UserDetails loginByUsernameAndPassword(String username, String password) throws UsernameNotFoundException {
//
//
//        Map<String,Object> resBody = new HashMap();
//
//        resBody.put("id", username);
//        resBody.put("password", password);
///*
//
//        HttpEntity requestEntity = new HttpEntity(resBody);
//*/
//
//        Map result;
//
//
//        try{
//
//            result = commonService.procRestTemplate("/login", HttpMethod.POST, resBody, "");
//
//        } catch (Exception e) {
//            throw new BadCredentialsException(e.getMessage());
//
//        }
//
//
//        List role = new ArrayList();
//
//
//        for(String auth : (List<String>)result.get("auth"))
//        {
//            role.add(new SimpleGrantedAuthority(auth));
//        }
//
//
//        User user = new User((String)result.get("id"), (String)result.get("password"), role);
//
//        user.setToken((String)result.get("token"));
//        user.setExpireDate((Long)result.get("expireDate"));
//        user.setName((String)result.get("name"));
//        user.setImgPath((String)result.get("imgPath"));
//
//        return user;
//    }


//    public UserDetails loadUserInfoByUsername(String username,SsoAuthenticationDetails details) throws UsernameNotFoundException {
//
//
//        Map result;
//        Map restUserInfo;
//
//        try{
//            result = commonService.procRestTemplate("/user/getUser/"+username+"/", HttpMethod.GET, null, "");
//        } catch (Exception e) {
//            throw new BadCredentialsException(e.getMessage());
//        }
//        List role = new ArrayList();
//
//
//        restUserInfo = (Map) result.get("User");
//        String adminYn = (String) restUserInfo.get("adminYn");
//
//
//        if (adminYn.equalsIgnoreCase("Y"))
//            role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
//        else
//            role.add(new SimpleGrantedAuthority("ROLE_USER"));
//
//
//
//        User user = new User((String)restUserInfo.get("userId"), "N/A", role);
//       /*
//        *  햇갈림....세션아디가 토큰인지...유저아디가 토큰인지;;;
//        */
//        //user.setToken(details.getId());
////        user.setToken(details.getSessionId());
////        user.setName((String)restUserInfo.get("name"));
////        user.setImgPath((String)restUserInfo.get("imgPath"));
//
//        return user;
//    }
}
