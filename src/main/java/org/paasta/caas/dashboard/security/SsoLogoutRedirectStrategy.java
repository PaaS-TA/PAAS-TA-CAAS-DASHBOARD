package org.paasta.caas.dashboard.security;

//import org.openpaas.paasta.portal.web.user.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.RedirectStrategy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * {@link RedirectStrategy} redirecting to the UAA logout page.
 * <p/>
 * When the UAA has performed the logout on its side, the page is
 * redirected again to the specified URL.
 *
 * @author Sebastien Gerard
 */
public class SsoLogoutRedirectStrategy implements RedirectStrategy {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoLogoutRedirectStrategy.class);

    private final String uaaLogoutUrl;

    public SsoLogoutRedirectStrategy(String uaaLogoutUrl) {
        this.uaaLogoutUrl = uaaLogoutUrl;
    }


//    @Autowired
//    public CommonService commonService;


    @Override
    public void sendRedirect(HttpServletRequest request, HttpServletResponse response, String url) throws IOException {
        LOGGER.info("Logout : " + uaaLogoutUrl + "?redirect=" + serverDomain(request));
        response.sendRedirect(uaaLogoutUrl + "?redirect=" + serverDomain(request) + "/login");
    }

    private String serverDomain(HttpServletRequest request) {
        String forward = request.getHeader("x-forwarded-proto");
        LOGGER.info("Forward ::::::::: " + forward);
        String serverDomain = request.getRequestURL().toString().replace("/logout", "");
        if (forward != null) {
            serverDomain = serverDomain.replace("http", "").replace("https", "");
            serverDomain = forward + serverDomain;
        }
        LOGGER.info("Logout ::::::::  " + serverDomain + "/login");
        return serverDomain;
    }

}
