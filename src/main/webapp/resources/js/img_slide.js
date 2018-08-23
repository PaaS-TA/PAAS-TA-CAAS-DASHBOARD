// 16-12-29 하코사 trb3047
(function($){
    var defaults = {
        //slide, fade 타입 설정
        type : "slide",
        //자동 반복 시간
        set_time : 5000,
        //넘기는 시간
        animate_time : 400,
        //버튼 출력 유무
        btn_use : true,
        //화살표 출력 유무
        arrow_use : true,
        //자동 반복 유무
        auto_start : true,
        //슬라이드 방향
        slide_way : "right",
        //100%이미지 적용 유무
        responsive_type : "y", 
        //버튼 이미지
        mbtn_off : "../resources/images/icons/btn_off.png",
        mbtn_on : "../resources/images/icons/btn_on.png",
        l_btn : "../resources/images/icons/btn_roll_prevon.png",
        r_btn : "../resources/images/icons/btn_roll_nexton.png",
        //마우스 오버시 멈춤
        hover_stop : true,
        //화살표 오버 효과
        arrow_hide : true
    }
    $.fn.slider = function(options){

        var obj = this;
        
        var setting = {};
        for(var name in defaults){
            setting[name] = defaults[name];
        }
        //옵션 수정
        if(options){
            for(var name in options){
                setting[name] = options[name];
            }
        };
        
        var type = setting.type;
        var set_time = setting.set_time;
        var animate_time = setting.animate_time;
        var auto_start = setting.auto_start;
        var btn_use = setting.btn_use;
        var arrow_use = setting.arrow_use;
        var slide_way = setting.slide_way;
        var responsive_type = setting.responsive_type;
        var hover_stop = setting.hover_stop;
        var arrow_hide = setting.arrow_hide;
        
        var slide_w = obj.parent().width()+17;
        var slide_num = 0;
        var slider = obj.children();
        var slide_total = slider.length;

        //슬라이드 연속클릭 방지
        var timer = 0;

        console.log(slide_w);

        //사이즈 조절 추가
        $(".nav_toggle").change(function() {
            slide_w = obj.parent().width();
            slider.css({"width":slide_w});
        });
        // $('.sidebar-toggle').on('click', function(){
        //     setTimeout(function(){
        //         slide_w = obj.parent().width();
        //         slider.css({"width":slide_w});
        //     }, 300);
        // });

        var element = document.getElementById('visual');
        new ResizeSensor(element, function() {
            slide_w = obj.parent().width();
            slider.css({"width":slide_w});
        });

        //슬라이드 css 조절
        if(type == "slide"){
        obj.parent().css({"overflow":"hidden"})
        obj.css({"width":slide_total*slide_w,"overflow":"hidden"});
        slider.css({"float":"left","width":slide_w});
        }else if(type == "fade"){
            var height = obj.children().height();
            obj.css({"position":"relative","height":height});
            slider.css({"display":"none","position":"absolute","top":0,"left":0});
            slider.eq(0).css("display","block");
        }
        if(responsive_type == "y"){
            slider.each(function(){
                var src = $(this).find("img").attr("src");
                var height = obj.height();
                $(this).find("img").remove();
                $(this).css({"height":height,"background":"url("+src+") center 0 no-repeat"});
            })
            $(window).resize(function(){
                slide_w = obj.parent().width();
                slider.css({"width":slide_w});
            })
        }

        //슬라이드 초기 상태 저장
        var slide_array = new Array();
        slider.each(function(e){
            slide_array[e] = $(this);
        });
        //conle.log(slide_array);
        //버튼 사용시 버튼 출력
        if(btn_use == true){
            obj.parent().append("<div class='mbtn'></div>");
            var mbtn = obj.siblings(".mbtn");
            var mbtn_off = setting.mbtn_off;
            var mbtn_on = setting.mbtn_on;
            for(var i=0;i<slider.length;i++){
                mbtn.append("<a href='#'><img src='"+mbtn_off+"'></a>");
            }
            mbtn.children("a").eq(0).children("img").attr("src",mbtn_on);
            //버튼 위치 조절
            function btn_position(){
                var btn = mbtn.children("a");
                obj.parent().css({"position":"relative"});
                mbtn.css({"position":"absolute","top":"95%","left":0,"width":"100%","text-align":"center"});
                btn.css({"margin-right":"10px"});
            }
            btn_position();
        }
        //화살표 사용시 화살표 출력
        if(arrow_use == true){
            obj.parent().append("<a href='#' class='arrow l_btn'><img src='"+setting.l_btn+"'></a>");
            obj.parent().append("<a href='#' class='arrow r_btn'><img src='"+setting.r_btn+"'></a>");
            var arrow = obj.siblings(".arrow");
            var l_btn = obj.siblings(".l_btn");
            var r_btn = obj.siblings(".r_btn");
            //화살표 위치 조절
            function arrow_position(){
                var height = obj.height();
                var arrow_h = l_btn.find("img").height();
                var top = (height-50)/2;
                obj.parent().css({"position":"relative"});
                arrow.css({"position":"absolute","top":top});
                l_btn.css({"left":0});
                r_btn.css({"right":0});
            }
            arrow_position();

            //화살표 효과
            if(arrow_hide == true){
              arrow.hide();
              obj.parent().hover(function(){
                arrow.fadeIn(400);
              },function(){
                arrow.fadeOut(400);
              })
            }
        }
        //자동반복 시작
        setting.play = function(){
            if(auto_start == true){
                setting.play.interval = setInterval(auto,set_time);
            }
        };
        //자동반복 멈춤
        setting.stop = function(){
            if(auto_start == true){
                clearInterval(setting.play.interval);
            }
        };
        //자동반복 사용시 자동반복 적용
        if(auto_start == true){
            setting.play();
        }
        //자동반복
        function auto(){
            if(slide_way == "right"){
                if(slide_num == slide_total-1){
                    slide_num = 0;
                }else{
                    slide_num++;
                }
                right_slide(slide_num);
            }else if(slide_way == "left"){
                if(slide_num == 0){
                    slide_num = slide_total-1;
                }else{
                    slide_num--;
                }
                left_slide(slide_num);
            }
           
        }
       
        
        function fade(slide_num){
            obj.children().eq(slide_num).stop().fadeIn(animate_time).siblings().fadeOut(animate_time);
            btn_trans();
        }
        //슬라이드 기본골자
        function right_slide(slide_num){
            //이미지가 1개 이상일 경우 우측에서 슬라이드
            if(slide_total > 1 && timer == 0){
                timer = 1;
                if(type == "slide"){
                    slide_w = obj.parent().width();
                    obj.children().eq(0).after(slide_array[slide_num]);
                    slider = obj.children();
                    //console.log(slide_array[check_num]);
                    obj.stop().animate({
                         "margin-left":-slide_w
                    },animate_time,function(){
                         var first = slider[0];
                         obj.append(first);
                         obj.css("margin-left",0);
                         //console.log(slider[0]);
                         timer = 0; 
                    });
                    btn_trans();
                }else if(type == "fade"){
                   fade(slide_num); 
                   timer = 0; 
                }
            }
              
        }
        //좌측 슬라이드
        function left_slide(slide_num){
            //이미지가 1개 이상일 경우 좌측에서 슬라이드
            if(slide_total > 1 && timer == 0){
                timer = 1;
                if(type == "slide"){
                    obj.append(slide_array[slide_num]);
                    slider = obj.children();
                    var last = slider[slide_total-1];
                    obj.prepend(last);
                    obj.css("margin-left",-slide_w); 
                    obj.stop().animate({
                        "margin-left":0
                    },animate_time,function(){
                        timer = 0;
                    });
                    btn_trans();
                }else if(type == "fade"){
                   fade(slide_num);
                   timer = 0;
                }
                
            }
        }
        //버튼 변경 기본골자
        function btn_trans(){ 
           if(btn_use == true){ mbtn.children("a").eq(slide_num).children("img").attr("src",mbtn_on).parent("a").siblings("a").find("img").attr("src",mbtn_off); 
            }
        }
        obj.siblings(".mbtn").children("a").on('click',function(e){
            setting.stop();
            e.preventDefault();
            var check_num = $(this).index();
            //console.log(slider);
            if(check_num == slide_num){
               
            }else if(check_num > slide_num){
                slide_num = check_num;
                right_slide(check_num);
            }else if(check_num < slide_num){
                slide_num = check_num;
                left_slide(check_num);
            }
            setting.play();
        })
        obj.siblings(".l_btn").on('click',function(e){
            setting.stop();
            e.preventDefault();
            slide_way = "left";
            if(slide_num == 0){
                slide_num = slide_total-1;
            }else{
                slide_num--;
            }
            left_slide(slide_num);
            //console.log(num);
            setting.play();
        })
        obj.siblings(".r_btn").on('click',function(e){
            setting.stop();
            e.preventDefault();
            slide_way = "right";
            if(slide_num == slide_total-1){
                slide_num = 0;
            }else{
                slide_num++;
            }
            right_slide(slide_num);
            setting.play();
        })
        //마우스 오버시 멈춤
         if(hover_stop == true){
            obj.hover(function(){
                setting.stop();
            },function(){
                setting.play();
            })
        }
        
    };
})(jQuery);

//사용 선언
$(function(){
    $(".slider").slider(function(){
    });
});

    