<%--
  Private Registry Info
  @author hrjin
  @version 1.0
  @since 2019.11.19
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <jsp:include page="../common/contentsTab.jsp"/>
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
        <div class="sortable_wrap custom-sortable_wrap">
            <div class="sortable_top">
                <p>Private Registry Info</p>
            </div>
        </div>
        <div class="account_table access">
            <p>Private Registry 도커 이미지를 Container 상에 배포 및 사용하기 위한 사전 작업 설명 페이지입니다.</p>
        </div>
    </div>
    <div class="cluster_tabs clearfix"></div>
    <%--How to access :: BEGIN--%>
    <div class="cluster_content01 row two_line two_view paB40">
        <div class="sortable_wrap custom-sortable_wrap">
            <div class="sortable_top">
                <p>How to access</p>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title">
                    <p>1. Private Registry Deployment YAML 생성</p>
                </div>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="vimDeploymentYaml">
                        <p>vim my-private-reg-deployment.yaml</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="vimDeploymentYaml"></i>
                    </div>
                </div>
                <div class="maT10"></div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="podForPrivateDockerRegistry">
                        <p>---</p>
                        <p>apiVersion: apps/v1</p>
                        <p>kind: Deployment</p>
                        <p>metadata:</p>
                        <p>&nbsp;&nbsp;name: private-registry</p>
                        <p>spec:</p>
                        <p>&nbsp;&nbsp;selector:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;matchLabels:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;app: private-registry</p>
                        <p>&nbsp;&nbsp;replicas: 1</p>
                        <p>&nbsp;&nbsp;template:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;metadata:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;labels:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;app: private-registry</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;spec:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;containers:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- name: private-registry</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;image: <span class="dockerImageName"></span></p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ports:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- containerPort: 5000</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;imagePullSecrets:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- name: paasta</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>2. Deployment 배포 및 확인</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="deployCommandKubectl">
                        <p>kubectl apply -f my-private-reg-deployment.yaml</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="deployCommandKubectl"></i>
                    </div>
                </div>
                <div class="maT10"></div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="confirmPodCommandKubectl">
                        <p>kubectl get pods</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="confirmPodCommandKubectl"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title">
                    <p>3. Private Registry 접근을 위한 Service YAML 생성</p>
                </div>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="vimServiceYaml">
                        <p>vim my-private-reg-service.yaml</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="vimServiceYaml"></i>
                    </div>
                </div>
                <div class="maT10"></div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="svcForPrivateDockerRegistry">
                        <p>---</p>
                        <p>apiVersion: v1</p>
                        <p>kind: Service</p>
                        <p>metadata:</p>
                        <p>&nbsp;&nbsp;name: private-registry</p>
                        <p>spec:</p>
                        <p>&nbsp;&nbsp;type: NodePort</p>
                        <p>&nbsp;&nbsp;selector:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;app: private-registry</p>
                        <p>&nbsp;&nbsp;ports:</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;- port: 5000</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>4. Service 생성 및 확인</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="deployServiceCommandKubectl">
                        <p>kubectl apply -f my-private-reg-service.yaml</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="deployServiceCommandKubectl"></i>
                    </div>
                </div>
                <div class="maT10"></div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="confirmServiceCommandKubectl">
                        <p>kubectl get services</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="confirmServiceCommandKubectl"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--How to access :: END--%>
</div>

<script type="text/javascript">
    var G_GUIDE_DOCKER_IMAGE_NAME;
    var G_GUIDE_CLUSTER_URI;

    var getRegistryInfo = function () {
        procViewLoading('show');
        G_GUIDE_DOCKER_IMAGE_NAME = '<c:out value="${privateRegistryImageName}" />';
        G_GUIDE_CLUSTER_URI = '<c:out value="${privateRegistryUrl}" />';

        $('.dockerImageName').html(G_GUIDE_DOCKER_IMAGE_NAME);
        $('.caasMasterUrl').html(G_GUIDE_CLUSTER_URI);
        $('.nameSpace').html(NAME_SPACE);

        procViewLoading('hide');
    };

    // BIND
    $(".custom-access-copy-button").on("click", function () {
        var item = document.getElementById($(this).attr('about'));
        var reqValue = item.innerText || item.textContent;
        var resultString = (procSetExecuteCommandCopy(reqValue)) ? '스크립트를 복사했습니다.' : '스크립트 복사에 실패했습니다.';
        procSetLayerPopup('알림', resultString, '확인', null, 'x', null, null, null);
    });


    // ON LOAD
    $(document.body).ready(function () {
        getRegistryInfo();
    });
</script>