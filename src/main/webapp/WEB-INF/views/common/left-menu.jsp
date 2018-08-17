<%--
  Left Menu

  author: REX
  version: 1.0
  since: 2018.08.07
--%>
<div>Left Menu</div>
<div>
    <ul>
        <li><a href="javascript:void(0);" onclick="procMovePage('/');">[ HOME ]</a></li>
        <li><a href="javascript:void(0);" onclick="procMovePage('/users');">[ USERS ]</a></li>
        <li><a href="javascript:void(0);" onclick="procMovePage('/services');">[ SERVICES ]</a></li>
        <%--TODO :: REMOVE--%>
        <li><a href="javascript:void(0);" onclick="procMovePage('/cluster/namespaces');">[ NAMESPACES ]</a></li>
        <%--TODO :: MODIFY--%>
        <%--<li><a href="javascript:void(0);" onclick="procMovePage('/cluster/overview');">[ CLUSTER ]</a></li>--%>
        <li><a href="javascript:void(0);" onclick="procMovePage('/workload/deployments');">[ DEPLOYMENTS ]</a></li>

        <li><a href="javascript:void(0);" onclick="procMovePage('/workload/replicasets');">[ REPLICASETS ]</a></li>
        <li><a href="javascript:void(0);" onclick="procMovePage('/cluster/persistentvolume');">[ PERSISTENT VOL ]</a></li>

        <li><a href="javascript:void(0);" onclick="procMovePage('/roles');">[ ROLE ]</a></li>
    </ul>
</div>