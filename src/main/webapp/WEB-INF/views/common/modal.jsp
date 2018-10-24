<%--
  Modal

  author: REX
  version: 1.0
  since: 2018.09.03
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="modal fade in" id="commonLayerPopup">
    <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
            <div class="modal-content">
                <!-- header -->
                <div class="modal-header">
                    <!-- 닫기(x) 버튼 -->
                    <button type="button" class="close" data-dismiss="modal"><span id="commonLayerPopupCloseButton">×</span></button>
                    <!-- header title -->
                    <h4 class="modal-title"><span id="commonLayerPopupTitle">-</span></h4>
                </div>
                <!-- body -->
                <div class="modal-body custom-access-popup-contents" id="commonLayerPopupContents">
                    -
                </div>
                <!-- Footer -->
                <div class="modal-footer" id="commonLayerPopupFooterWrap" style="display: none;">
                    <button type="button" class="btns2 colors4" data-dismiss="modal" id="commonLayerPopupSuccessButton">확인</button>
                    <button type="button" class="btns2 colors5" data-dismiss="modal" id="commonLayerPopupCancelButton" style="display: none;">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>
