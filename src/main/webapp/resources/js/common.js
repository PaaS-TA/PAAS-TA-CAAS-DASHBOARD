$(document).ready(function() {
    var ckmenu = $.cookie('ckmenu');
    if(ckmenu == 1) {
        $(".navcheck").prop("checked", true);
        navToggle();
        navMenu();
        NavScroll();
        accountImg();
        //Organizations();
    };

    $(window).resize(function() {
        resize_mini();
        resize_big();
        NavScroll();
        accountImg();
        //Organizations();
    });

    //SIDE NAV
    navToggle();
    navMenu();
    NavScroll();
    accountImg();
    //Organizations();

    $(".nav_toggle").change(function() {
        if($(".navcheck").prop("checked")) {
            $.cookie('ckmenu', $(".navcheck").val());
        } else {
            $.removeCookie("ckmenu");
        }
        navToggle();
        navMenu();
        NavScroll();
        catalogIcons();
    });

    // 로그인
    $(".loginWrap").each( function(){
        var Whight = $(window).height() / 2;
        var loginWrap = $(this).innerHeight() / 2;
        var loginarea = Whight - loginWrap - 60 + 'px';
        $(this).css("top" , loginarea );
    });


    function resize_mini() {
        var Whight = $(window).height();
        var Whight2 = $(window).height() - 76;
        var headerSW = $('header').attr('class');
        var conHeight = $('.content').innerHeight();
        if (conHeight > Whight) {
            $("nav").css({ 'height': conHeight + 137 + 'px' });
        } else {
            $("nav").css({ 'height': 100 + '%' });
        };

        if( headerSW == "header account"){
            $("nav,.contain").css("top",76);
        }
         //else {}
    }

    //20180312 내계정
    function resize_big() {
        var Whight = $(window).height() - 137;
        var Whight2 = $(window).height() - 76;
        var headerSW = $('header').attr('class');
        var scH = $(".nav_big .scroll_style").height();
        var scNav = $(".nav_big .scroll_style").innerHeight;

        if( headerSW == "header account"){
            $("nav,.contain").css("top",76);
            $(".scroll_style").css({ 'height': Whight2 + 'px' });
        }
         else {
            $(".scroll_style").css({ 'height': Whight + 'px' });
        }

        /*
        //201803
        if( scNav >= Whight ){
            $(".nav_2d").css({'left' : 108+'px'});
        } else {
            $(".nav_2d").css({'left' : 120+'px'});
        }
        */

    }

    function navToggle() {
        var navtog = $(".navcheck").is(":checked");
        if (navtog == true) {
            $("nav").removeClass('nav_big').addClass('nav_mini');
            $(".contain").addClass('left');
            resize_mini();
            NavScroll();

        } else if (navtog == false) {
            $("nav").removeClass('nav_mini').addClass('nav_big');
            $(".contain").removeClass('left');
            resize_big();
            NavScroll();
        };
    };


    function navMenu(gnbclass) {
        var gnbclass = $('nav').attr('class');
        if (gnbclass == 'nav_big') {
            $('.nav_big .nav_1d > li').on('click', function() {
                $('.nav_1d li').removeClass('cur');
                $(this).addClass('cur');
            });

        } else if (gnbclass == 'nav_mini') {
            $('.nav_mini .nav_1d > li').on('click', function() {
                $('.nav_1d li').removeClass('cur');
                $(this).addClass('cur');
            });
        };
    };

    function NavScroll() {
        var gnbclass = $('nav').attr('class');
        var element = $('nav > div').jScrollPane();
        var api = element.data('jsp');
        var winHeight = element.innerHeight();
        $('.scroll_H').css("height" , winHeight+'px');

        if (gnbclass == 'nav_big') {
            element.jScrollPane({ autoReinitialise: true });
        } else if (gnbclass == 'nav_mini') {
            api.destroy();
        }
        catalogIcons();
    };

    //20180307 play
    $(".monitoring > ul > li").on("click" , function(){
        var Monitoring = $(".monitoring ul li").index(this);
        var MonitoringLength = Monitoring;
        $(".monitoring > ul > li").css('display','none');
        if(MonitoringLength == 2){
            MonitoringLength = 0;
            $(".monitoring > ul > li").eq(MonitoringLength).css('display','block');
            inMonitoring();
        } else {
            $(".monitoring > ul > li").eq(MonitoringLength+1).css('display','block');
            inMonitoring();
        }
        function inMonitoring(){
            $("#col_in1 button.btns").css('display','none');
            $("#col_in1 button.btns").eq(Monitoring).css('display','block');
        }
    });

    function accountImg(){
        $(".account_left > dl > dt").each(function(){
            var account_img = $(this).innerWidth();
            //alert(account_img);
            $(this).css("height" , account_img );
        });
    }

    //20180308
    var name_inputTitleSW = true;
    $(".name_inputTitle").on("click" , function(){
        var MainTitle = $(".headTH2 span").text();
        var tempTitle = MainTitle;
        $(".colright_btn li > ol").toggleClass('on');
        $(".headT").css("display","block");
        $(".tempTitle").val(MainTitle);
    });

    $(".yess").on("click" , function(){
        var asdasdasd = $(".tempTitle").val();
        $(".headTH2 span").html(asdasdasd);
        $(".headT").css("display","none");
    });

    $(".nos,.nos2").on("click" , function(){
        //$(".headTH2 span").html(tempTitle);
        $(".headT,.headT2").css("display","none");
    });

    $(".fa-ellipsis-v").on('click', function(){
        $(".colright_btn li > ol").toggleClass('on')//.fadeIn(300);
    });

    $(".sortable_wrap,.sortable_line > li").on("mouseenter", function(){
        $(this).addClass('on');
    });

    $(".sortable_wrap,.sortable_line > li").on("mouseleave", function(){
        $(this).removeClass('on');
    });

    //Catalog Menu
    $(".nav_1d li:eq(0)").on("mouseenter" , function(){
        $(".nav_2d").stop().fadeIn();
    });

    $("header,.contain").on("mouseenter", function(){
        nav_2dOut();
    });

    $(".nav_2d").on("mouseleave" , function(){
        nav_2dOut();
    });

    $(".btns4").on("mouseenter" , function(){
        $(this).children('div').css("display","block");
    });

    $(".btns4").on("mouseleave" , function(){
        $(this).children('div').css("display","none");
    });

    function nav_2dOut(){
        $(".nav_2d").fadeOut();
    }

    // Allcheck
    $(".checkAll").change(function() {
        $(".checkSel").prop('checked', $(this).prop("checked"));
    });

     $(".checkAll2").change(function() {
        $(".checkSel2").prop('checked', $(this).prop("checked"));
    });

    $(".checkSel").change(function() {
        var allcount = $(".checkSel").length;
        var ckcount = $(".checkSel:checked").length;
        $(".checkAll").prop('checked', false);
        if (allcount == ckcount) {
            $(".checkAll").prop('checked', true);
        };
    });

    $(".checkSel2").change(function() {
        var allcount = $(".checkSel2").length;
        var ckcount = $(".checkSel2:checked").length;
        $(".checkAll2").prop('checked', false);
        if (allcount == ckcount) {
            $(".checkAll2").prop('checked', true);
        };
    });

    /* input */
    $("input").on("click" , function(){
        $(this).addClass("active");
    });

    $("input").change( function(){
        $(this).removeClass("active");
    });

    // file
    $('.hide_file').change(function() {
        $('.subfile').val($(this).val());
    });

    // Disk


    $('.BG_wrap input').each( function(){
        var BG_wrap = $(this).val();
        $(this).parent().delay(500).animate({'top':- BG_wrap + '%'},800);
        $(this).closest('dl').find("span.rights").html(BG_wrap);
    });

    $(".a0001").on("click" , function(){
        $(this).attr("disabled","disabled");
        var instanceS = $(".instanceS").text();
        $(this).closest('dl').find("span.instanceS").html('<input class="instance_in" type="text" value='+ instanceS +' />');
    });

    $(".b0001").on("click" , function(){
        $(".a0001").removeAttr("disabled");
        var TempInput = $(this).closest('dl').find("input").val();
        $(this).closest('dl').find("span.instanceS").text(TempInput);
    });

     $(".a0002").on("click" , function(){
        $(this).attr("disabled","disabled");
        var memS = $(".memS").text();
        $(this).closest('dl').find("span.memS").html('<input class="instance_in" type="text" value='+ memS +' />');
    });

    $(".b0002").on("click" , function(){
        $(".a0002").removeAttr("disabled");
        var TempInput = $(this).closest('dl').find("input").val();
        $(this).closest('dl').find("span.memS").text(TempInput);
    });

     $(".a0003").on("click" , function(){
        $(this).attr("disabled","disabled");
        var diskS = $(".diskS").text();
        $(this).closest('dl').find("span.diskS").html('<input class="instance_in" type="text" value='+ diskS +' />');
    });

    $(".b0003").on("click" , function(){
        $(".a0003").removeAttr("disabled");
        var TempInput = $(this).closest('dl').find("input").val();
        $(this).closest('dl').find("span.diskS").text(TempInput);
    });

    /*
    $('.BG_wrap input').each( function() {
        var BG_wrap = $(this).val();
        $(this).parent().delay(500).animate({'top':- BG_wrap + '%'},800);
        $(this).closest('dl').find("span.rights").html(BG_wrap);
    });
    */

    //20180312
    $("th .fa-edit,.table_edit .fa-edit").on("click" , function(){
        $("body > div").addClass('account_modify');
        $(this).toggleClass("on");
        $(this).parents("tr").next("tr").toggleClass("on");
        $(this).parents("tr").addClass("off");
    });

    $(".btns_sw").on("click" , function(){
        $(this).parents("tr").prev("tr").removeClass("off");
        $(this).parents("tr").prev("tr").find("i").toggleClass("on");
        $(this).parents("tr").toggleClass("on");
    });

    // 20180313 세부사항 보기,닫기
    $(".organization_sw").on("click" , function(){
        var wrap_line = $(".organization_wrap");
        $(this).parents(wrap_line).toggleClass("on");
        var updown = $(this).children("i").attr('class');
        if( updown == 'fas fa-chevron-down' ){
            $(this).toggleClass("colors5");//.children("i").removeClass("fa-chevron-down").addClass("fa-chevron-up");
            $(this).html("<i class='fas fa-chevron-up'></i> 세부사항 닫기");
        } else {
            $(this).toggleClass("colors5");//.children("i").removeClass("fa-chevron-up").addClass("fa-chevron-down");
            $(this).html("<i class='fas fa-chevron-down'></i> 세부사항 보기");
        }
    });

    $(".weekday li").on("mouseenter", function(){
        $(this).addClass("on");
        $(this).on("click" , function(){
            $(".weekday li").removeClass('cur');
            $(this).addClass('cur');
        });
    });

    $(".weekday li").on("mouseleave", function(){
        $(this).removeClass("on");
    });

    $(".organization_wrap").on("mouseenter" , function(){
        $(this).find(".organization_dot").addClass('on');
    });

    $(".serviceOn,.lauthOn").on("click" ,function(){
        $(".service_dl,.lauth_dl").toggleClass("on");
    });

    $(".variableSW").on("click" , function(){
        $("#DLid1").toggleClass("on");
    });

    $(".variableSW2").on("click" , function(){
        $("#DLid2").toggleClass("on");
    });

    $(".organization_dot").on("click" , function(){
        $(this).children("ul").toggleClass("on");

        $(this).children("ul").children("li").eq(0).on("click" , function(){
            var ttt = $(this).find("div.organization_btn")
            $(this).parents(".pull-right").siblings(ttt).toggleClass("on");

            //$(this).parent("ul").toggleClass("on");
            //$(this).find("div").children(".organization_btn").toggleClass("on");
            //$(".organization_btn").toggleClass("on"); //ok
        });
    });

    $(".organization_wrap").on("mouseleave" , function(){
        $(this).find(".organization_dot").removeClass('on');
        $(this).find(".organization_dot").children("ul").removeClass("on");
    });

    $(".yess2,.nos2").on("click" , function(){
        $(this).closest("div.organization_btn").removeClass("on");
    });


    // $(".organizations_wrap canvas").each(function(){
    //     var asdfghj = $(".organizations_wrap").innerWidth;
    //     $(this).css("width" , asdfghj );
    // });

    /*
    $(".organization_wrap").on("mouseenter" , function(){
        var asdfasdf = $(".organization_dot");
        $(this).find(asdfasdf).addClass('on');
        var name_inputTitleSW2 = true;

        $(".name_inputTitle2").each("click" , function(){
            //alert("asda");
            $(this).find('ul').toggleClass("on");
        });
    });




    $(".organization_wrap").on("mouseleave" , function(){
        $(this).find(asdfasdf).removeClass("on").children('ul').toggleClass("on");
    });

    $(".organization_dot").on("click" ,function(){
        $(this).children('ul').toggleClass("on");
    });
    */

    //20180314
    /*
    $(".name_inputTitle2").on("click" , function(){
        //var asd123 = $(".organization_title_wrap");
        //$(this).find("ul").toggleClass("on"); ok
        var MainTitle3 = $(this).parent('ul').parent('div').parent('div').siblings("p").text();
        //var tempTitle3 = MainTitle3;

        $(this).find("input").val(MainTitle3);
        $(".headT2").css("display","block");

        //$(".tempTitle").val(MainTitle3);
    });
    */

    /*
    $(".name_inputTitle2").on("click" , function(){
        //var zzzzz = $(".organization_wrap").index();
        //var zzzz = $(this).parent('.organization_wrap').find('.tit').text();
        //var zzzz = $(this).parent('.organization_title_wrap').children(".tempTitle").text();
        //alert(zzzz);

        $(this).parent('ul').toggleClass("on"); //ok
        $(".organization_btn").toggleClass("on"); //ok
        //$(this).parent('.organization_wrap').children(".tempTitle").val('asd');
    });

    $(".yess2").on("click" , function(){
        //var asdasdasd12 = $(".tempTitle").val();
        //$(this).siblings("p").html(asdasdasd12);
        //$(this).parent('div').css("display","none");

        $(".organization_btn").toggleClass("on");
    });

    $(".nos2").on("click" , function(){
       $(".organization_btn").toggleClass("on");
    });
    */


    //20180307 아이콘 정렬
    function catalogIcons(){
        var InicoDiv = $(".cWrap_line > ul.icon > li").innerWidth();
        $(".cWrap_line > ul.icon > li").css("min-height" , InicoDiv );
        $(".cWrap_line > ul.icon > li > div").css("min-height" , InicoDiv );
        if( $(window).width() >= 1650 ){
            var iconW = $(".icon").children('li').length * 123;
            var iconM = $(".icon").children('li').length * 58 - 40;
            $(".icon").css("width", iconW + iconM );

            //view chart
            $(".table_SW").css("display" , "table-cell" );
        } /*else if( $(window).width() <= 940 ){
            //var iconW = $(".icon").children('li').length * 123;
            //alert(InicoDiv);
        } */else {
            $(".icon").css("width", 100 + '%' );

            //view chart
            $(".table_SW").css("display" , "block" );

            //$(".table_SW").attr("colspan" , '2' );
        }
    }

    function Organizations(){
        var aaaadddd = $(".organization_table").innerWidth();
        if ( aaaadddd <= 600 ){
            $(".organization_table_in").addClass('on');
        } else {
            $(".organization_table_in").removeClass('on');
        }
    }

    // 20180323 아이콘 텍스트
    $(".icon li div img").on("mouseenter", function(){
        var IcoTitle = $(this).attr("alt");
        var IcoCopy = $(this).attr("title");
        $(".icon_TT").html(IcoTitle);
        $(".icon_TC").html(IcoCopy);
    });

    $('.scroll_wrap,.table_wraps').jScrollPane({autoReinitialise: true});

    $( "#sortable" ).sortable({placeholder: "portlet-placeholder"}).disableSelection();

    // $(".fa-cog").on("click" function(){
    //     var asdasd = $('#switch1').prop('checked', true);
    //     if( $('#switch1:checked') ){
    //         $("#check1").prop('checked', true);
    //     } else {
    //         $("#check1").prop('checked', false);
    //     }
    //     //$("#check1").checked();
    // });

    // 클립
    $(".bar").on("click", function(){
        var inA = $("#in_a").val();
        $("#out_a").val(inA);
    });
    // 클립 끝



    // table line .two_view table tbody tr,
    $(".line_tables tbody tr").on("mouseenter", function(){
        $(".two_view table tbody tr,.line_tables tbody tr").removeClass('cur').css('border-bottom','1px solid #e7eaec');
        $(this).addClass('cur');
        $(this).prev().css('border-color','#00aacc');
        $(this).css('border-bottom','1px solid #00aacc');
    });

    $(".account_left > dl > dt").on("mouseenter" , function(){
        $(this).toggleClass("on");
    });

    $(".account_left > dl > dt").on("mouseleave" , function(){
        $(this).toggleClass("on");
    });

	//180403 탭 추가
	$('.monitor_tabs li').click(function(){
		var tab_c = $(this).attr('name');
		var content = tab_c.substr(4, 1);
		if(tab_c == 'tab01'){
			$('.monitor_tabs li:nth-child(1)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_on');;
			$('.monitor_tabs li:nth-child(2)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_right');
			$('.monitor_tabs li:nth-child(3)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_right');
			for (i=0; i<4; i++)
			{
				$('.monitor_content0'+i).hide();
			}
			$('.monitor_content0'+content).show();
			$('.service_only').hide();
		} else if(tab_c == 'tab02'){
			$('.monitor_tabs li:nth-child(1)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_left');;
			$('.monitor_tabs li:nth-child(2)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_on');
			$('.monitor_tabs li:nth-child(3)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_right');
			for (i=0; i<4; i++)
			{
				$('.monitor_content0'+i).hide();
			}
			$('.monitor_content0'+content).show();
			$('.service_only').show();
		} else if(tab_c == 'tab03'){
			$('.monitor_tabs li:nth-child(1)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_left');;
			$('.monitor_tabs li:nth-child(2)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_left');
			$('.monitor_tabs li:nth-child(3)').removeClass('monitor_tabs_on monitor_tabs_right monitor_tabs_left').addClass('monitor_tabs_on');
			for (i=0; i<4; i++)
			{
				$('.monitor_content0'+i).hide();
			}
			$('.monitor_content0'+content).show();
		}
	});

	//툴팁추가
	$('.monitor_red').mouseenter(function(){
		$('.monitor_tultip').show();
	});
	$('.monitor_red').mouseleave(function(){
		$('.monitor_tultip').hide();
	});

	//대시보드 메뉴 부분 새로만듬
	$('.space_pop_menu > i').click(function(){
		$('.space_pop_submenu').toggle();
	});

    /*180409 alert layer*/
    // alert page
    $(".errorWrap").each( function(){
        var Whight = $(window).height() / 2;
        var errorWrap = $(this).innerHeight() / 2;
        var errorarea = Whight - errorWrap - 60 + 'px';
        $(this).css("top" , errorarea );
    });

    $(".alertOn").click(function(){
        $(".alertLayer").addClass("moveAlert");
    }),
    setInterval(function(){
        $(".alertLayer").removeClass("moveAlert");
    }, 5000);

    $(".alertClose").click(function(){
        $(this).parents(".alertLayer").removeClass("moveAlert");
    });

    /* 180807 cluster*/
    $('.cluster_tabs li').click(function(){
		var tab_c = $(this).attr('name');
		var content = tab_c.substr(4, 1);
		if(tab_c == 'tab01'){
			$('.cluster_tabs li:nth-child(1)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_on');
			$('.cluster_tabs li:nth-child(2)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_right');
            $('.cluster_tabs li:nth-child(3)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_right');
            $('.cluster_tabs li:nth-child(4)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_right');
			for (i=0; i<5; i++)
			{
				$('.cluster_content0'+i).hide();
			}
			$('.cluster_content0'+content).show();
			$('.service_only').hide();
		} else if(tab_c == 'tab02'){
			$('.cluster_tabs li:nth-child(1)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_left');
			$('.cluster_tabs li:nth-child(2)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_on');
            $('.cluster_tabs li:nth-child(3)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_right');
            $('.cluster_tabs li:nth-child(4)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_right');
			for (i=0; i<5; i++)
			{
				$('.cluster_content0'+i).hide();
			}
			$('.cluster_content0'+content).show();
			$('.service_only').show();
		} else if(tab_c == 'tab03'){
			$('.cluster_tabs li:nth-child(1)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_left');
			$('.cluster_tabs li:nth-child(2)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_left');
            $('.cluster_tabs li:nth-child(3)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_on');
            $('.cluster_tabs li:nth-child(4)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_right');
			for (i=0; i<5; i++)
			{
				$('.cluster_content0'+i).hide();
			}
			$('.cluster_content0'+content).show();
		} else if(tab_c == 'tab04'){
			$('.cluster_tabs li:nth-child(1)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_left');
			$('.cluster_tabs li:nth-child(2)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_left');
            $('.cluster_tabs li:nth-child(3)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_right');
            $('.cluster_tabs li:nth-child(4)').removeClass('cluster_tabs_on cluster_tabs_right cluster_tabs_left').addClass('cluster_tabs_on');
			for (i=0; i<5; i++)
			{
				$('.cluster_content0'+i).hide();
			}
			$('.cluster_content0'+content).show();
        }
    });
    
    $('.sort-arrow').click(function(){
        $(this).toggleClass('sort');
    });

    $('.table-search-on').click(function(){
        if($(this).hasClass('on') === false){
            $(this).siblings('.table-search').css('display', 'block');
            $(this).toggleClass('on');
            $(this).find('i').removeClass('fa-search').addClass('fa-times');
            $(this).siblings('.table-search').focus();
        }
        else{
            $(this).siblings('.table-search').css('display', 'none');
            $(this).toggleClass('on');
            $(this).find('i').removeClass('fa-times').addClass('fa-search');
        }
    });

    // 테이블 상세 숨김 보이기
    $('.view_table_wrap.toggle > table > tbody > tr:nth-child(odd)').click(function(){
        $(this).next().toggle();
    });

    $('.graph-legend li').click(function(){
        $('.graph-legend li').removeClass('on');
        $(this).addClass('on');
    });

    // 차트 시간 탭
    $("ul.graph-legend li").click(function () {
        // 탭
        $("ul.graph-legend li").removeClass("on");
        $(this).addClass("on");
        var term = $(this).attr("rel");
        createChart(term, "cpu"); // 처음에 차트 그림
        createChart(term, "mem");
        createChart(term, "disk");
    });
});

//넘버 카운팅
function updown(objNum,plusMinus) {
	if (plusMinus=="+") {
		var n = $('.bt_up'+objNum).index(this);
		var num = $(".num"+objNum+":eq("+n+")").val();
		num = $(".num"+objNum+":eq("+n+")").val(num*1+1);
	} else {
		var n = $('.bt_down'+objNum).index(this);
		var num = $(".num"+objNum+":eq("+n+")").val();
		if(num > 0){
			num = $(".num"+objNum+":eq("+n+")").val(num*1-1);
		}
	}
}

// 차트 색상 가져오기
function getColors(type) {
    var color = "";
    switch(type){
        case 'cpu' : 
            color = "#07ceb0"
            break;
        case 'mem' :
            color = "#3076b2"
            break;
        case 'disk' :
            color = "#fe8d14"
            break;
    }
    return color;
}

// 차트 데이터
function getDatas(term) {
    var data = 'https://demo-live-data.highcharts.com/time-data.csv';
    switch(term){
        case 'current' :
        case '1h' : 
            break;
        case '6h' :
            break;
        case '1d' :
            break;
        case '7d':
            break;
        case '30d':
            break;
    }
    return data;
}

// 차트 그리기
function createChart(term, type) {
Highcharts.chart('areachart'+type, {
        chart: {
            type: 'area',
        },
        title: {
            text: ''
        },
        subtitle: {
            text: '8월6일, 2018 08:45 오전',
            align: 'right',
            style: {
                color: '#888888',
                fontSize: '10px'
            }
        },
        data: {
            csvURL: getDatas(term),
            enablePolling: term == "current", // 현재 일때에만 데이터 새로 부름
            dataRefreshRate : 60 // 리프래시 최소시간 : 1초
        },
        xAxis: {
            type: 'datetime',
            crosshair: true
        },
        yAxis: {
            title: {
              text: ''
            },
            max: 10, // 데이터가 들어오면 max min 변경 해야함
            min: -10
        },
        legend: {
            enabled: false
        },
        tooltip: {
          //headerFormat: '',
          pointFormat: 'kube-flannel-ds: <b>{point.y:.2f}%</b><br/>',
          //footerFormat:''
        },
        plotOptions: {
            area: {
                color: getColors(type),
                fillColor: {
                linearGradient: {
                    x1: 0,
                    y1: 0,
                    x2: 0,
                    y2: 1
                },
                stops: [
                    [0, getColors(type)],
                    [1, Highcharts.Color(getColors(type)).setOpacity(0).get('rgba')]
                ]
              },
              marker: {
                radius: 1
              },
              lineWidth: 1,
              threshold: null
            }
        },

        credits: { // logo hide
            enabled: false
        }
    });
}