<%--
  Left Menu
  author: REX
  version: 1.0
  since: 2018.08.07
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<nav style="height: 90%;">
    <div class="scroll_style">
        <ul class="nav_1d caas_nav">
            <li id="left-menu-intro" onclick="procMovePage('<%= Constants.CAAS_INIT_URI %>');">
                <dl>
                    <dt>
                        <div id="lnbimg19" class="lefticos">
                        </div>
                    </dt>
                    <dd>
                        <p>
                            Intro
                        </p>
                    </dd>
                </dl>
            </li>
            <li id="left-menu-workloads" onclick="procMovePage('<%= Constants.URI_WORKLOAD_OVERVIEW %>');">
                <dl>
                    <dt>
                        <div id="lnbimg17" class="">

                        </div>
                    </dt>
                    <dd>
                        <p>
                            Workloads
                        </p>
                    </dd>
                </dl>
            </li>
            <li id="left-menu-services" onclick="procMovePage('<%= Constants.URI_SERVICES %>');">
                <dl>
                    <dt>
                        <div id="lnbimg18" class="">

                        </div>
                    </dt>
                    <dd>
                        <p>
                            Services
                        </p>
                    </dd>
                </dl>
            </li>
            <li id="left-menu-storages" onclick="procMovePage('<%= Constants.URI_STORAGES %>');">
                <dl>
                    <dt>
                        <div id="lnbimg20" class="">

                        </div>
                    </dt>
                    <dd>
                        <p>
                            Storages
                        </p>
                    </dd>
                </dl>
            </li>
        </ul>
    </div>
</nav>
