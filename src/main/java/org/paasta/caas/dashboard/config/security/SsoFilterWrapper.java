package org.paasta.caas.dashboard.config.security;

import javax.servlet.Filter;

/**
 * Wrapper around a {@link Filter}. This wrapper is used because if a
 * {@link Filter} is defined as a Spring bean, it will be automatically
 * registered in the security chain.
 *
 * @author Sebastien Gerard
 */
class SsoFilterWrapper {

    /**
     * Returns a wrapper around the specified filter.
     */
    static SsoFilterWrapper wrap(Filter filter){
        return new SsoFilterWrapper(filter);
    }

    private final Filter filter;

    SsoFilterWrapper(Filter filter) {
        this.filter = filter;
    }

    /**
     * Un-wraps the filter.
     */
    Filter unwrap() {
        return filter;
    }
}
