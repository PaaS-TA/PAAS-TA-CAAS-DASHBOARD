package org.paasta.caas.dashboard.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

/**
 * Tiles Config 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.07
 */
@Configuration
public class TilesConfig {

    /**
     * Tiles configurer tiles configurer.
     *
     * @return the tiles configurer
     */
    @Bean
    public TilesConfigurer tilesConfigurer() {
        final TilesConfigurer configurer = new TilesConfigurer();
        configurer.setDefinitions("WEB-INF/tiles/tiles.xml");
        configurer.setCheckRefresh(true);
        return configurer;
    }


    /**
     * Tiles view resolver tiles view resolver.
     *
     * @return the tiles view resolver
     */
    @Bean
    public TilesViewResolver tilesViewResolver() {
        final TilesViewResolver resolver = new TilesViewResolver();
        resolver.setViewClass(TilesView.class);
        return resolver;
    }

}
