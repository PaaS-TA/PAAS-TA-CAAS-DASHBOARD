<%--
  Contents tab

  author: CISS
  version: 1.0
  since: 2018.08.30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="servletPath" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:set var="pathArray" value="${fn:split(servletPath,'/')}" />
<c:forEach var="path" items="${pathArray}" varStatus="g">

    <c:choose>
        <c:when test="${g.index eq 0}"><!-- cass -->
            <c:set var="pathLevel1" value="${path}" />
        </c:when>
        <c:when test="${g.index eq 1}"><!-- clusters / workloads / services  -->
            <c:set var="pathLevel2" value="${path}" />
        </c:when>
        <c:when test="${g.index eq 2}"><!-- resource name -->
            <c:set var="pathLevel3" value="${path}" />
        </c:when>
        <c:when test="${g.index eq 3}"><!-- Detail name -->
            <c:set var="pathLevel4" value="${path}" />
        </c:when>
        <c:when test="${g.index eq 4}"><!-- event / yaml -->
            <c:set var="pathLevel5" value="${path}" />
        </c:when>

    </c:choose>
</c:forEach>

<div class="cluster_tabs clearfix">
    <c:choose>
        <c:when test="${pathLevel2 eq 'clusters'}">
            <c:choose>
                <c:when test="${pathLevel3 eq 'nodes'}">
                    <li name="tab01"
                         <c:if test="${pathLevel5 eq 'summary'}"> class="cluster_tabs_on"</c:if>
                         <c:if test="${pathLevel5 ne 'summary'}"> class="cluster_tabs_right"
                             onclick="procMovePage('<%=Constants.URI_CLUSTER_NODES%>'+'/${pathLevel4}/summary');"
                         </c:if>
                        >Summary</li>
                    <li name="tab02"
                        <c:if test="${empty pathLevel5}"> class="cluster_tabs_on"</c:if>
                        <c:if test="${!empty pathLevel5}"> class="cluster_tabs_right"
                            onclick="procMovePage('<%=Constants.URI_CLUSTER_NODES%>'+'/${pathLevel4}');"
                        </c:if>
                        >Details</li>
                    <li name="tab03"
                        <c:if test="${pathLevel5 eq 'events'}"> class="cluster_tabs_on"</c:if>
                        <c:if test="${pathLevel5 ne 'events'}"> class="cluster_tabs_right"
                            onclick="procMovePage('<%=Constants.URI_CLUSTER_NODES%>'+'/${pathLevel4}/events');"
                        </c:if>
                        >Events</li>
                </c:when>
                <c:when test="${pathLevel3 eq 'namespaces'}">
                    <li name="tab01"
                        <c:if test="${empty pathLevel5}"> class="cluster_tabs_on"</c:if>
                        <c:if test="${!empty pathLevel5}"> class="cluster_tabs_right"
                            onclick="procMovePage('<%=Constants.URI_CLUSTER_NAMESPACES%>'+'/${pathLevel4}');"
                        </c:if>
                        >Details</li>
                    <li name="tab02"
                        <c:if test="${pathLevel5 eq 'events'}"> class="cluster_tabs_on"</c:if>
                        <c:if test="${pathLevel5 ne 'events'}"> class="cluster_tabs_right"
                            onclick="procMovePage('<%=Constants.URI_CLUSTER_NAMESPACES%>'+'/${pathLevel4}/events');"
                        </c:if>
                        >Events</li>
                </c:when>
            </c:choose>
        </c:when>

        <c:when test="${pathLevel2 eq 'workloads'}">
            <c:choose>
                <c:when test="${pathLevel3 eq 'overview'}">
                    <li name="tab01" class="cluster_tabs_on">Overview</li>
                    <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>');">Deployments</li>
                    <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>');">Pods</li>
                    <li name="tab04" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICA_SETS%>');">Replica Sets</li>
                </c:when>
                <c:when test="${pathLevel3 eq 'deployments'}">
                    <c:choose>
                        <c:when test="${empty pathLevel4}">
                            <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_OVERVIEW%>');">Overview</li>
                            <li name="tab02" class="cluster_tabs_on">Deployments</li>
                            <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>');">Pods</li>
                            <li name="tab04" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICA_SETS%>');">Replica Sets</li>
                        </c:when>
                        <c:otherwise>
                            <li name="tab01"
                                <c:if test="${empty pathLevel5}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${!empty pathLevel5}"> class="cluster_tabs_right"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>'+'/${pathLevel4}');"
                                </c:if>
                                >Details</li>
                            <li name="tab02"
                                <c:if test="${pathLevel5 eq 'events'}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${pathLevel5 ne 'events'}"> class="cluster_tabs_right"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>'+'/${pathLevel4}/events');"
                                </c:if>
                                >Events</li>
                            <li name="tab03"
                                <c:if test="${pathLevel5 eq 'yaml'}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${pathLevel5 ne 'yaml'}"> class="cluster_tabs_right yamlTab"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>'+'/${pathLevel4}/yaml');"
                                </c:if>
                                >YAML</li>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${pathLevel3 eq 'pods'}">
                    <c:choose>
                        <c:when test="${empty pathLevel4}">
                            <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_OVERVIEW%>');">Overview</li>
                            <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>');">Deployments</li>
                            <li name="tab03" class="cluster_tabs_on">Pods</li>
                            <li name="tab04" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICA_SETS%>');">Replica Sets</li>
                        </c:when>
                        <c:otherwise>
                            <li name="tab01"
                                <c:if test="${empty pathLevel5}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${!empty pathLevel5}"> class="cluster_tabs_right"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>'+'/${pathLevel4}');"
                                </c:if>
                                >Details</li>
                            <li name="tab02"
                                <c:if test="${pathLevel5 eq 'events'}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${pathLevel5 ne 'events'}"> class="cluster_tabs_right"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>'+'/${pathLevel4}/events');"
                                </c:if>
                                >Events</li>
                            <li name="tab03"
                                <c:if test="${pathLevel5 eq 'yaml'}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${pathLevel5 ne 'yaml'}"> class="cluster_tabs_right yamlTab"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>'+'/${pathLevel4}/yaml');"
                                </c:if>
                                >YAML</li>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${pathLevel3 eq 'replicaSets'}">
                    <c:choose>
                        <c:when test="${empty pathLevel4}">
                            <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_OVERVIEW%>');">Overview</li>
                            <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>');">Deployments</li>
                            <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>');">Pods</li>
                            <li name="tab04" class="cluster_tabs_on">Replica Sets</li>
                        </c:when>
                        <c:otherwise>
                            <li name="tab01"
                                <c:if test="${empty pathLevel5}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${!empty pathLevel5}"> class="cluster_tabs_right"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICA_SETS%>'+'/${pathLevel4}');"
                                </c:if>
                                >Details</li>
                            <li name="tab02"
                                <c:if test="${pathLevel5 eq 'events'}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${pathLevel5 ne 'events'}"> class="cluster_tabs_right"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICA_SETS%>'+'/${pathLevel4}/events');"
                                </c:if>
                                >Events</li>
                            <li name="tab03"
                                <c:if test="${pathLevel5 eq 'yaml'}"> class="cluster_tabs_on"</c:if>
                                <c:if test="${pathLevel5 ne 'yaml'}"> class="cluster_tabs_right yamlTab"
                                    onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICA_SETS%>'+'/${pathLevel4}/yaml');"
                                </c:if>
                                >YAML</li>
                        </c:otherwise>
                    </c:choose>
                </c:when>
            </c:choose>
        </c:when>

        <c:when test="${pathLevel2 eq 'services'}">
            <c:choose>
                <c:when test="${!empty pathLevel3}">
                    <li name="tab01"
                        <c:if test="${empty pathLevel4}"> class="cluster_tabs_on"</c:if>
                        <c:if test="${!empty pathLevel4}"> class="cluster_tabs_right"
                            onclick="procMovePage('<%=Constants.URI_SERVICES%>'+'/${pathLevel3}');"
                        </c:if>
                        >Details</li>
                    <li name="tab02"
                        <c:if test="${pathLevel4 eq 'events'}"> class="cluster_tabs_on"</c:if>
                        <c:if test="${pathLevel4 ne 'events'}"> class="cluster_tabs_right"
                            onclick="procMovePage('<%=Constants.URI_SERVICES%>'+'/${pathLevel3}/events');"
                        </c:if>
                        >Events</li>
                    <li name="tab03"
                        <c:if test="${pathLevel4 eq 'yaml'}"> class="cluster_tabs_on"</c:if>
                        <c:if test="${pathLevel4 ne 'yaml'}"> class="cluster_tabs_right yamlTab"
                            onclick="procMovePage('<%=Constants.URI_SERVICES%>'+'/${pathLevel3}/yaml');"
                        </c:if>
                        >YAML</li>
                </c:when>
            </c:choose>
        </c:when>

        <c:when test="${pathLevel2 eq 'storages'}">
            <c:choose>
                <c:when test="${!empty pathLevel3}">
                    <li name="tab01"
                            <c:if test="${empty pathLevel4}"> class="cluster_tabs_on"</c:if>
                            <c:if test="${!empty pathLevel4}"> class="cluster_tabs_right"
                                onclick="procMovePage('<%=Constants.URI_STORAGES%>'+'/${pathLevel3}');"
                            </c:if>
                    >Details</li>
                    <li name="tab02"
                            <c:if test="${pathLevel4 eq 'events'}"> class="cluster_tabs_on"</c:if>
                            <c:if test="${pathLevel4 ne 'events'}"> class="cluster_tabs_right"
                                onclick="procMovePage('<%=Constants.URI_STORAGES%>'+'/${pathLevel3}/events');"
                            </c:if>
                    >Events</li>
                    <li name="tab03"
                            <c:if test="${pathLevel4 eq 'yaml'}"> class="cluster_tabs_on"</c:if>
                            <c:if test="${pathLevel4 ne 'yaml'}"> class="cluster_tabs_right yamlTab"
                                onclick="procMovePage('<%=Constants.URI_STORAGES%>'+'/${pathLevel3}/yaml');"
                            </c:if>
                    >YAML</li>
                </c:when>
            </c:choose>
        </c:when>

        <c:when test="${pathLevel2 eq 'intro'}">
            <c:choose>
                <c:when test="${pathLevel3 eq 'overview'}">
                    <li name="tab01" class="cluster_tabs_on">Overview</li>
                    <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_INTRO_ACCESS_INFO%>');">Access</li>
                    <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_INTRO_PRIVATE_REGISTRY_INFO%>');">Private Registry</li>
                </c:when>
                <c:when test="${pathLevel3 eq 'accessInfo'}">
                    <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_INTRO_OVERVIEW%>');">Overview</li>
                    <li name="tab02" class="cluster_tabs_on">Access</li>
                    <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_INTRO_PRIVATE_REGISTRY_INFO%>');">Private Registry</li>
                </c:when>
                <c:when test="${pathLevel3 eq 'privateRegistryInfo'}">
                    <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_INTRO_OVERVIEW%>');">Overview</li>
                    <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_INTRO_ACCESS_INFO%>');">Access</li>
                    <li name="tab03" class="cluster_tabs_on">Private Registry</li>
                </c:when>
            </c:choose>
        </c:when>

    </c:choose>
    <%--</ul>--%>
    <div class="cluster_tabs_line"></div>
</div>

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function () {
    // 기존 탭클릭 이벤트 남아있는 부분 제거
        $('.cluster_tabs li').off('click');
    });

    $(".cluster_tabs_on").css({ "cursor": "default"});
</script>
