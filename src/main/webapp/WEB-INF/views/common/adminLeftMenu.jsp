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
            <li id="left-menu-users" onclick="procMovePage('<%= Constants.URI_USERS %>');">
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
            <li id="left-menu-roles" onclick="procMovePage('<%= Constants.URI_ROLES %>');">
                <dl>
                    <dt>
                        <div id="lnbimg11" class="">

                        </div>
                    </dt>
                    <dd>
                        <p>
                            Roles
                        </p>
                    </dd>
                </dl>
            </li>
        </ul>
    </div>
</nav>
