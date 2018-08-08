package org.paasta.caas.dashboard.temp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/index")
public class TempController {

    @GetMapping
    public ModelAndView getTempMain() {
        return new ModelAndView() {{
            setViewName("index");
        }};
    }
}
