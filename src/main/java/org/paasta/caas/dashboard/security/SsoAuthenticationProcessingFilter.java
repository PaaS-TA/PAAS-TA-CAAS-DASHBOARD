package org.paasta.caas.dashboard.security;

import org.paasta.caas.dashboard.common.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.filter.OAuth2ClientAuthenticationProcessingFilter;
import org.springframework.security.oauth2.provider.OAuth2Authentication;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Extension of {@link OAuth2ClientAuthenticationProcessingFilter} that uses the
 * {@link org.springframework.security.authentication.AuthenticationManager}.
 * This implementation also starts authentication if there is no authentication and
 * if the current request requires authentication.
 *
 * @author Sebastien Gerard
 */
public class SsoAuthenticationProcessingFilter extends OAuth2ClientAuthenticationProcessingFilter {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationProcessingFilter.class);

    private AuthenticationDetailsSource<HttpServletRequest, ?> detailsSource;

    private CommonService commonService;

    public SsoAuthenticationProcessingFilter() {
        super("/");
    }


    @Override
    protected boolean requiresAuthentication(HttpServletRequest request, HttpServletResponse response) {
        Authentication securityAuthentication = SecurityContextHolder.getContext().getAuthentication();

        if(!(securityAuthentication == null && super.requiresAuthentication(request, response))){
            return false;
        } else {
            return true;
        }
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
          throws AuthenticationException, IOException, ServletException {
        final Authentication authentication = super.attemptAuthentication(request, response);

        LOGGER.info("** attemptAuthentication");

        if (detailsSource != null) {
            request.getSession().invalidate();
            ((OAuth2Authentication) authentication).setDetails(detailsSource.buildDetails(request));
        }

        Object obj = request.getSession().getAttribute("serviceInstanceId");
        String serviceInstanceId = obj != null ? obj.toString() : "";

        if (request.getSession() != null && serviceInstanceId != "") {
            SsoAuthenticationDetails ssoAuthenticationDetails = (SsoAuthenticationDetails) authentication.getDetails();
            ssoAuthenticationDetails.setManagingServiceInstance(serviceInstanceId);
        }

        AuthenticationManager authenticationManager = getAuthenticationManager();

        return authenticationManager.authenticate(authentication);
    }

    /**
     * Sets the optional source providing {@link Authentication#getDetails() authentication details}.
     */
    public void setDetailsSource(AuthenticationDetailsSource<HttpServletRequest, ?> detailsSource) {
        this.detailsSource = detailsSource;
    }

    public void setCommonService(CommonService commonService) {
        this.commonService = commonService;
    }






}
