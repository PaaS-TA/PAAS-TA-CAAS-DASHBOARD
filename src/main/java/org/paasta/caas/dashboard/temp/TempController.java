package org.paasta.caas.dashboard.temp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Temp Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.08
 */
@Controller
@RequestMapping("/")
public class TempController {

    /**
     * Gets temp main.
     *
     * @return the temp main
     */
    // TODO :: REMOVE
    @GetMapping
    public ModelAndView getTempMain() {
        return new ModelAndView() {{

            setViewName("redirect:/clusters/overview");
        }};
    }
}
