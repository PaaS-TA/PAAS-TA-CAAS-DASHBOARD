package org.paasta.caas.dashboard.config;

//import org.springframework.http.HttpMethod;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;

//import java.util.Map;

/**
 * 최초 dashboard 진입시 RuleSet 관련 설정하는 컨트롤러이다. Cluster Overview 로 redirect 한다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class acceptController {

    @GetMapping(value = {"/accept/ruleset"})
    public ModelAndView acceptRuleSet(HttpServletRequest request) {

        HttpSession session  = request.getSession();

        // TODO :: DEVELOPMENT
        // 유저 Account(ex. admin)의 RULE_SET_CD에 대한 TB_RULE_SET Table 의 컬럼 내용조회하여,
        // "RESOURCE_CD"_"VERB_CD" 형식으로 iterator 해서 Session 에 Set 해주세요.
        // SELECT TRS.RESOURCE_CD, TRS.VERB_CD
        //  FROM TB_USER TU, TB_RULE_SET TRS
        //  WHERE TU.RULE_SET_CD = TRS.RULE_SET_CD // 0000   0001
        //        TU.ACC_ID = 'admin'
        // 테이블명은 가칭입니다.

        // TEST SETTING
        session.setAttribute("REPLICASET", "TRUE" );
        session.setAttribute("REPLICASET_VIEW", "TRUE" );
        session.setAttribute("REPLICASET_EXECUTE", "TRUE" );

        //session.invalidate();

        return new ModelAndView() {{
            setViewName("redirect:/clusters/overview");
        }};
    }

    // TODO :: REMOVE
    // 테스트용입니다. 다른 계정 접속시 세션 삭제 참고용
    @GetMapping(value = {"/session/invalidate"})
    public ModelAndView sessionInvalidate(HttpServletRequest request) {

        HttpSession session  = request.getSession();
        session.invalidate();

        return new ModelAndView() {{
            setViewName("redirect:/clusters/overview");
        }};

    }
}
