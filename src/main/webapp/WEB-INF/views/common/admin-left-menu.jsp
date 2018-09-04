
<%--
  Admin Left Menu

  author: REX
  version: 1.0
  since: 2018.08.23
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<nav style="height: 90%;">
    <div class="scroll_style">
        <ul class="nav_1d caas_nav">
            <%--<li onclick="location.href='admin_access.html'">--%>
            <li id="left-menu-accessInfo" onclick="procMovePage('<%= Constants.CAAS_BASE_URL %>/accessInfo');">
                <dl>
                    <dt>
                        <div id="lnbimg9" class="">
                        </div>
                    </dt>
                    <dd>
                        <p>
                            Access
                        </p>
                    </dd>
                </dl>
            </li>
            <%--<li class="cur">--%>
            <li id="left-menu-users" onclick="procMovePage('<%= Constants.CAAS_BASE_URL %>/users');">
                <dl>
                    <dt>
                        <div id="lnbimg10" class="lefticos">

                        </div>
                    </dt>
                    <dd>
                        <p>
                            Users
                        </p>
                    </dd>
                </dl>
            </li>
            <%--<li onclick="location.href='admin_role.html'">--%>
            <li id="left-menu-roles" onclick="procMovePage('<%= Constants.CAAS_BASE_URL %>/roles');">
                <dl>
                    <dt>
                        <div id="lnbimg11" class="">

                        </div>
                    </dt>
                    <dd>
                        <p>
                            Role
                        </p>
                    </dd>
                </dl>
            </li>
        </ul>
    </div>
</nav>