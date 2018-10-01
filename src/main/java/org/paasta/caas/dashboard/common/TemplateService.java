package org.paasta.caas.dashboard.common;

import freemarker.template.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import java.util.Map;

/**
 * TemplateService 클래스.
 *
 * @author hyerin
 * @version 1.0
 * @since 2018.07.24
 */
@Service
public class TemplateService {

    private static final Logger logger = LoggerFactory.getLogger(TemplateService.class);

    private Configuration configuration;

    @Lazy
    @Autowired
    public TemplateService(Configuration configuration) {
        this.configuration = configuration;
        logger.info( "freemaker.Configuration : {}", this.configuration.toString());
    }

    /**
     * Template 내용 중 일부를 입력받은 모델의 내용으로 치환하여 반환하는 클래스
     * @param templateName
     * @param model
     * @return String
     */
    public String convert(String templateName, Map<String, Object> model) {
        String yml;
        try {
            yml = FreeMarkerTemplateUtils.processTemplateIntoString(configuration.getTemplate(templateName), model);
            logger.info("original yml {}",yml);
        } catch (Exception e) {
            logger.error( "Occured unexpected exception...", e );
            return null;
        }
        return yml;
    }
    
}
