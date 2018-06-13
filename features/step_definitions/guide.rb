# author: BruceLi

=begin
  1.首次安装应用，判断是否展示引导页；
    滑到最后一张，判断是否展示“登录/注册”和“进入首页”两个按钮；
    点击“登录/注册”按钮，判断是否展示登录界面。
  2.滑动到最后一张引导页，点击“进入首页”按钮，判断引导页是否还存在。
=end


# 滚动引导页到最后一页
def swipe_to_last_guide_view
    guideIsExist = exists { id("Guide_Page_View") }
    if guideIsExist
      for i in 0...2
        swipe(direction: "left", element: nil)
        sleep(0.25)
      end
    end
  end
  
  # 跳过引导页
  def dismiss_guide_page
    guideExist = exists { id("Guide_Page_View") }
    puts guideExist ? "存在引导页面" : "不存在引导页面" 
    if guideExist
      swipe_to_last_guide_view
      sleep(1)
      button("Guide_Start_Btn").click
      sleep(0.25)
    end
  end


# @guide_01
#   首次安装应用，判断是否展示引导页； 
#   滑到最后一张，判断是否展示“登录/注册”和“进入首页”两个按钮； 
#   点击“登录/注册”按钮，判断是否展示登录界面。
When(/^展示引导页$/) do
    guideIsExist = exists { id("Guide_Page_View") } 
    puts guideIsExist ? "存在引导页面" : "不存在引导页面" 
    expect(guideIsExist).to be true 
end

Then(/^滑动到最后一页$/) do
    swipe_to_last_guide_view
    sleep(1)
end

Then(/^展示“登录\/注册”和“进入首页”两个按钮$/) do
    $loginBtnIsExist = exists { id("Guide_Login_Btn") }
    puts $loginBtnIsExist ? "存在“登录/注册”按钮" : "不存在“登录/注册”按钮" 
    expect($loginBtnIsExist).to be true

    startBtnIsExist = exists { id("Guide_Start_Btn") }
    puts startBtnIsExist ? "存在“进入首页”按钮" : "不存在“进入首页”按钮" 
    expect(startBtnIsExist).to be true
end

When(/^点击“登录\/注册”按钮$/) do
    if $loginBtnIsExist
        button("Guide_Login_Btn").click
        
    else 
        puts "已登录"
    end
    sleep(1)
end

Then(/^展示登录界面$/) do
    if $loginBtnIsExist
        loginViewIsExist = exists { id("login_page") }
        puts loginViewIsExist ? "成功展示“登录界面" : "展示“登录界面”失败" 
        expect(loginViewIsExist).to be true
        sleep(1)
    end
end


# @guide_02 
#   滑动到最后一张引导页，点击“进入首页”按钮，判断引导页是否还存在。
When(/^滑动到最后一张引导页，点击“进入首页”按钮$/) do
    dismiss_guide_page
end

Then(/^退出引导页$/) do
    guideIsExist = exists { id("Guide_Page_View") } 
    puts guideIsExist ? "引导页面退出失败" : "成功退出“引导页面" 
    expect(guideIsExist).to be false
    sleep(2)
end
