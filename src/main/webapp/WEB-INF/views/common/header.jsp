<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Header
  author: REX
  version: 1.0
  since: 2018.08.07
--%>
<header class="header">
    <div class="logo">
        <a href="javascript:void(0);" onclick="procMovePage('/');"><h1><img src="<c:url value="/resources/images/main/logo.png"/>" alt=""/></h1></a>
        <%--<a href="#"><h1><img src="../resources/images/main/logo.png" alt=""/></h1></a>--%>
    </div>

    <!-- 2019 Spec
    <div class="gnb gnb_select">
        <select>
            <option selected>Namespace</option>
            <option>Namespace name 1</option>
            <option>Namespace name 2</option>
            <option>Namespace name 3</option>
        </select>
    </div>
    -->

    <div class="gnb search">
        <!--2019 Spec
        <input type="text" id="search-main" name="" class="search_form" placeholder="search" />
        <button name="button" class="btn" type="button">
            <i class="fas fa-search"></i>
        </button>
        -->
    </div>

    <ul class="right_nav clearfix">
        <!--2019 Spec
        <li>
            <div class="btn-group">
                <button href="#" class="dropdown-toggle caas-create"></button>
            </div>
        </li>
        <li>
            <div class="btn-group">
                <button href="#" class="dropdown-toggle caas-kebectl"></button>
            </div>
        </li>
        -->
        <!--2019 Spec
        <li>
            <div id="globes" class="btn-group">
                <button href="#" class="dropdown-toggle globe" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="fas fa-caret-down"></i></button>
                <ul class="dropdown-menu">
                    <li class="cur"><a href="#">Korean</a></li>
                    <li><a href="#">English</a></li>
                </ul>
            </div>
        </li>
        -->
        <li><!-- <a href="#" class="fas fa-user"></a> -->
            <div class="btn-group">
                <button href="#" class="dropdown-toggle user" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                </button>
                <div id="r_user" class="dropdown-menu">
                    <ul class="caas-user">
                        <li id="header-menu-accessInfo"><a href="javascript:void(0);" onclick="procMovePage('/accessInfo');">Access</a></li>
                        <li id="header-menu-users"><a href="javascript:void(0);" onclick="procMovePage('/caas/users');">User</a></li>
                        <li id="header-menu-roles"><a href="javascript:void(0);" onclick="procMovePage('/roles');">Role</a></li>
                        <%--<li class="cur"><a href="#">Access</a></li>
                        <li><a href="#">User</a></li>
                        <li><a href="#">Role</a></li>--%>
                    </ul>
                </div>
            </div>
        </li>
    </ul>
    <div class="header_bottom">
        <p class="tit">CaaS</p>
        <span class="nav_toggle"><!-- 180724 수정 -->
                <input type="checkbox" id="checkbox-1" name="" class="navcheck" value="1" >
                <label for="checkbox-1"></label>
            </span>
        <ul class="content_dev">
            <li>Clusters</li>
        </ul>
        <div class="btn-kuber">
            <button class="btns colors4" onclick="window.open('https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl')">Kubectl download</button>
        </div>
    </div>
</header>