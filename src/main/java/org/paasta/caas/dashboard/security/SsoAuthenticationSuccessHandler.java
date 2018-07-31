package org.paasta.caas.dashboard.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.ExceptionTranslationFilter;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Extension of {@link SavedRequestAwareAuthenticationSuccessHandler}
 * for the dashboard. In this case, {@link ExceptionTranslationFilter}
 * in charge of persisting the request is not called. So, this handler
 * is not able to recover the original request that was redirected
 * to the OAuth server. Once logged, the OAuth server redirects to the
 * original page, i.e., the current request. In order to continue
 * the filter chain, a refresh is performed.
 *
 * @author Sebastien Gerard
 */
public class SsoAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    private final RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws ServletException, IOException {
        requestCache.saveRequest(request, response);

        super.onAuthenticationSuccess(request, response, authentication);
    }
}
