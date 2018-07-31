package org.paasta.caas.dashboard.security;

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

    public SsoAuthenticationProcessingFilter() {
        super("/");
    }





/*
*   여기서 토큰 리플레쉬 해주쟈.
 */

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

        if (detailsSource != null) {
            ((OAuth2Authentication) authentication).setDetails(detailsSource.buildDetails(request));
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






}
