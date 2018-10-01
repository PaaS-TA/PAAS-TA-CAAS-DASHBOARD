package org.paasta.caas.dashboard.config.security;

import javax.servlet.Filter;

/**
 * SsoFilterWrapper 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
class SsoFilterWrapper {

    static SsoFilterWrapper wrap(Filter filter){
        return new SsoFilterWrapper(filter);
    }

    private final Filter filter;

    SsoFilterWrapper(Filter filter) {
        this.filter = filter;
    }

    Filter unwrap() {
        return filter;
    }
}
