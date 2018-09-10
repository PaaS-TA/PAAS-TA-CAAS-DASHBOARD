<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%--
  Created by IntelliJ IDEA.
  User: CISS
  Date: 7/5/2017
  Time: 11:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <c:otherwise></c:otherwise>
    </c:choose>
</c:forEach>

<div class="cluster_tabs clearfix">
    <c:choose>
        <c:when test="${pathLevel2 eq 'workloads'}">
            <c:choose>
                <c:when test="${pathLevel3 eq 'overview'}">
                    <li name="tab01" class="cluster_tabs_on"    onclick="procMovePage('<%=Constants.URI_WORKLOAD_OVERVIEW%>');">Overview</li>
                    <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>');">Deployments</li>
                    <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>');">Pods</li>
                    <li name="tab04" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICASETS%>');">Replica Sets</li>
                </c:when>
                <c:when test="${pathLevel3 eq 'deployments'}">
                    <c:choose>
                        <c:when test="${empty pathLevel4}">
                            <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_OVERVIEW%>');">Overview</li>
                            <li name="tab02" class="cluster_tabs_on"    onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>');">Deployments</li>
                            <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>');">Pods</li>
                            <li name="tab04" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICASETS%>');">Replica Sets</li>
                        </c:when>
                        <c:otherwise>
                            <li name="tab01" class="<c:if test="${empty pathLevel5}">cluster_tabs_on</c:if>
                                                    <c:if test="${!empty pathLevel5}">cluster_tabs_right</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>'+'/${pathLevel4}');">Details</li>
                            <li name="tab02" class="<c:if test="${pathLevel5 eq 'events'}">cluster_tabs_on</c:if>
                                                    <c:if test="${pathLevel5 ne 'events'}">cluster_tabs_right</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>'+'/${pathLevel4}/events');">Events</li>
                            <li name="tab03" class="<c:if test="${pathLevel5 eq 'yaml'}">cluster_tabs_on</c:if>
                                                    <c:if test="${pathLevel5 ne 'yaml'}">cluster_tabs_right yamlTab</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>'+'/${pathLevel4}/yaml');">YAML</li>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${pathLevel3 eq 'pods'}">
                    <c:choose>
                        <c:when test="${empty pathLevel4}">
                            <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_OVERVIEW%>');">Overview</li>
                            <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>');">Deployments</li>
                            <li name="tab03" class="cluster_tabs_on"    onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>');">Pods</li>
                            <li name="tab04" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICASETS%>');">Replica Sets</li>
                        </c:when>
                        <c:otherwise>
                            <li name="tab01" class="<c:if test="${empty pathLevel5}">cluster_tabs_on</c:if>
                                                    <c:if test="${!empty pathLevel5}">cluster_tabs_right</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>'+'/${pathLevel4}');">Details</li>
                            <li name="tab02" class="<c:if test="${pathLevel5 eq 'events'}">cluster_tabs_on</c:if>
                                                    <c:if test="${pathLevel5 ne 'events'}">cluster_tabs_right</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>'+'/${pathLevel4}/events');">Events</li>
                            <li name="tab03" class="<c:if test="${pathLevel5 eq 'yaml'}">cluster_tabs_on</c:if>
                                                    <c:if test="${pathLevel5 ne 'yaml'}">cluster_tabs_right yamlTab</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>'+'/${pathLevel4}/yaml');">YAML</li>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${pathLevel3 eq 'replicaSets'}">
                    <c:choose>
                        <c:when test="${empty pathLevel4}">
                            <li name="tab01" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_OVERVIEW%>');">Overview</li>
                            <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_DEPLOYMENTS%>');">Deployments</li>
                            <li name="tab03" class="cluster_tabs_right" onclick="procMovePage('<%=Constants.URI_WORKLOAD_PODS%>');">Pods</li>
                            <li name="tab04" class="cluster_tabs_on"    onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICASETS%>');">Replica Sets</li>
                        </c:when>
                        <c:otherwise>
                            <li name="tab01" class="<c:if test="${empty pathLevel5}">cluster_tabs_on</c:if>
                                                    <c:if test="${!empty pathLevel5}">cluster_tabs_right</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICASETS%>'+'/${pathLevel4}');">Details</li>
                            <li name="tab02" class="<c:if test="${pathLevel5 eq 'events'}">cluster_tabs_on</c:if>
                                                    <c:if test="${pathLevel5 ne 'events'}">cluster_tabs_right</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICASETS%>'+'/${pathLevel4}/events');">Events</li>
                            <li name="tab03" class="<c:if test="${pathLevel5 eq 'yaml'}">cluster_tabs_on</c:if>
                                                    <c:if test="${pathLevel5 ne 'yaml'}">cluster_tabs_right yamlTab</c:if>"
                                onclick="procMovePage('<%=Constants.URI_WORKLOAD_REPLICASETS%>'+'/${pathLevel4}/yaml');">YAML</li>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise></c:otherwise>
            </c:choose>
        </c:when>

        <c:when test="${pathLevel2 eq 'services'}">
            <c:choose>
                <c:when test="${!empty pathLevel3}">
                    <li name="tab01" class="<c:if test="${empty pathLevel4}">cluster_tabs_on</c:if>
                                            <c:if test="${!empty pathLevel4}">cluster_tabs_right</c:if>"
                        onclick="procMovePage('<%=Constants.URI_SERVICES%>'+'/${pathLevel3}');">Details</li>
                    <li name="tab02" class="<c:if test="${pathLevel4 eq 'events'}">cluster_tabs_on</c:if>
                                            <c:if test="${pathLevel4 ne 'events'}">cluster_tabs_right</c:if>"
                        onclick="procMovePage('<%=Constants.URI_SERVICES%>'+'/${pathLevel3}/events');">Events</li>
                    <li name="tab03" class="<c:if test="${pathLevel4 eq 'yaml'}">cluster_tabs_on</c:if>
                                            <c:if test="${pathLevel4 ne 'yaml'}">cluster_tabs_right yamlTab</c:if>"
                        onclick="procMovePage('<%=Constants.URI_SERVICES%>'+'/${pathLevel3}/yaml');">YAML</li>
                </c:when>
                <c:otherwise></c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise></c:otherwise>
    </c:choose>
    </ul>
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