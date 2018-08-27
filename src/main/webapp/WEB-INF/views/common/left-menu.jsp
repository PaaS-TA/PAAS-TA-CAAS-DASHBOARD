<%--
  Left Menu
  author: REX
  version: 1.0
  since: 2018.08.07
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<nav>
    <div class="scroll_style">
        <ul class="nav_1d caas_nav">
            <%--<li class="cur">--%>
            <li id="left-menu-clusters" onclick="procMovePage('/caas/clusters/overview');">
                <dl>
                    <dt>
                        <div id="lnbimg16" class="lefticos">
                        </div>
                    </dt>
                    <dd>
                        <p>
                            Clusters
                        </p>
                    </dd>
                </dl>
            </li>
            <%--<li onclick="location.href='caas_workloads.html'">--%>
            <li id="left-menu-workloads" onclick="procMovePage('/workloads/overview');">
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
            <%--<li onclick="location.href='caas_services.html'">--%>
            <li id="left-menu-services" onclick="procMovePage('/services');">
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
            <!--li>
                <dl>
                    <dt>
                        <div id="lnbimg19" class="">
                        </div>
                    </dt>
                    <dd>
                        <p>
                            Config
                        </p>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt>
                        <div id="lnbimg20" class="">
                        </div>
                    </dt>
                    <dd>
                        <p>
                            Storage
                        </p>
                    </dd>
                </dl>
            </li-->
        </ul>
    </div>
</nav>


<%--TODO :: REMOVE--%>
<%--<div>Left Menu--%>
<%--<br>--%>
<%--<br>--%>
<%--<a href="javascript:void(0);" onclick="procMovePage('/');">[ HOME ]</a>--%>
<%--<br>--%>
<%--<br>--%>
<%--</div>--%>
<%--<div>--%>
<%--조현구 전임님 ::--%>
<%--<ul>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/nodes');">[ NODES ]</a></li>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/workload/deployments');">[ DEPLOYMENTS ]</a></li>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/workload/pods');">[ PODS ]</a></li>--%>
<%--</ul>--%>
<%--</div>--%>
<%--<div>--%>
<%--진현리 전임님 ::--%>
<%--<ul>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/users');">[ USERS ]</a></li>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/roles');">[ ROLE ]</a></li>--%>
<%--</ul>--%>
<%--</div>--%>
<%--<div>--%>
<%--박혜린 전임님 ::--%>
<%--<ul>--%>
<%--<li>Service broker</li>--%>
<%--</ul>--%>
<%--</div>--%>
<%--<div>--%>
<%--김도현 책임님 ::--%>
<%--<ul>--%>
<%--<li>SSO</li>--%>
<%--</ul>--%>
<%--</div>--%>
<%--<div>--%>
<%--최윤석 책임님 ::--%>
<%--<ul>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/workload/replicasets');">[ REPLICASETS ]</a></li>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/cluster/persistentvolume');">[ PERSISTENT VOL ]</a></li>--%>
<%--</ul>--%>
<%--</div>--%>
<%--<div>--%>
<%--조형래 책임님 ::--%>
<%--<ul>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/services');">[ SERVICES ]</a></li>--%>
<%--<li><a href="javascript:void(0);" onclick="procMovePage('/cluster/namespaces');">[ NAMESPACES ]</a></li>--%>
<%--</ul>--%>
<%--</div>--%>