#移动端UI自动化测试--框架选择及案例分析


## 大纲
~~~Ruby
├── 简介
├── 目的
├── UI自动化测试框架的选择
├── 环境配置
├── 案例
├── 借助Appium来进行元素定位
└── 源码地址
~~~

## 1.简介
在日常开发中，自动化测试往往是开发人员比较头痛的事，特别是UI的自动化测试更是投入大收益小，很多公司情愿多招一个测试人员，也不愿意自己搭建一套UI自动化测试系统。

前几年使用TDD模式和XCode自带的XCTest开发过“Lighten”的早期版本，但后来由于各种原因，测试用例“年久失修”基本已经报废，现在基本全靠人工测试。在使用TDD模式开发的时候，优点挺多，比如能增强自己的全局思维，跳出牛角尖，从使用者的角度去设计接口，减少了很多冗余代码。当然缺点也明显，比如开发人员要把大量时间用在编写测试用例上，而且随着版本的迭代更新，测试用例也要跟着更新，大大的增加了开发人员的工作量。

这里不详细讨论单元测试和逻辑测试，主要探讨一下UI自动化测试的学习和实践。
[简书](https://www.jianshu.com/p/c3db8e5dc306)
[项目源码](https://github.com/SilongLi/AutoUITestDemo)
[脚本源码](https://github.com/SilongLi/AutoTestDemo)

## 2.目的
- 在APP交到测试或产品手里的时候，保证最起码页面显示和跳转逻辑等功能是正确的；
- 减少后期的开发迭代过程中，基本功能的自测时间；

## 3.UI自动化测试框架的选择
### 基本要求
- 支持不同平台的一套框架，包括安卓、苹果和前端等；
- 集成自动化框架，对原有项目的侵入尽量要小，接入成本尽量低；
- 稳定性要好；
- 可扩展性好；

市场上有很多自动化的框架，比如：Instrumentation、UIAutomator、Appium、UIAutomation、Calabash-ios等待，那我们应该怎样去选择呢？

大厂已经为我们开好路了，我们直接上车即可。

- [腾讯--移动APP自动化测试框架对比](https://mp.weixin.qq.com/s/pu1TKZhNW2L2BmvpjGzLCw)
- [美团--客户端自动化测试研究](https://tech.meituan.com/mobile_app_automation.html)

**根据市场调查，最终我们选择的UI自动化测试框架是：[Appium](http://appium.io/) + [Cucumber](https://docs.cucumber.io/) 的模式，其基本满足我先前提的所有要求。**

### 那么什么是Appium呢？
- [简介](https://github.com/appium/appium/blob/master/docs/en/about-appium/intro.md)
- [文档戳这里](https://github.com/appium/appium/blob/master/README.md)

原文是英文的，我这里做下总结。

说白了，Appium就是一个适用于native、hybird、mobile web和desktop apps等开发模式并支持模拟器（iOS、Android）和真机（iOS、Android、Windows、Mac）测试的、开源的跨平台自动化测试工具。Appium支持iOS、Android、Windows等多个平台的应用程序自动化测试，而且每个平台都有一个或多个驱动程序支持，我们可以根据不同的平台安装和配置驱动程序，具体的看上面文档。

### Appium的优点
- 1、所有平台都使用标准化的APIs，你无需重新编译和修改你的应用；
- 2、你可以使用任何你喜欢的与WebDriver兼容的语言（如：Java、Objective-C、JavaScript、PHP、Python、Ruby、C#、Clojure、Perl），结合Selenium WebDriver API和指定语言的客户端框架编写测试用例；
- 3、你可以使用任何测试框架；
- 4、Appium已经内建moblie web和hybird app支持。在同一个脚本中，你能在原生自动化和webView自动化中无缝切换，因为他们都使用了标准的WebDriver模型，这已经成为web自动化测试的标准；


### Cucumber 
- [文档](https://docs.cucumber.io/)
- [Wiki](https://github.com/cucumber/cucumber/wiki)

按照惯例，这里做下总结：

Cucumber是一个能够理解用**普通语言**来描述测试用例，支持行为驱动开发（[BDD](https://zh.wikipedia.org/wiki/%E8%A1%8C%E4%B8%BA%E9%A9%B1%E5%8A%A8%E5%BC%80%E5%8F%91)）的自动化测试工具，使用用Ruby编写，也支持Java和·Net等多种开发语言。

什么叫做用普通语言来描述测试用例呢，看下具体的案例，我的“引导页”的测试用例：

~~~Ruby
@guidepage
Feature: 引导页
  1.首次安装应用，判断是否展示引导页；
    滑到最后一张，判断是否展示“登录/注册”和“进入首页”两个按钮；
    点击“登录/注册”按钮，判断是否展示登录界面。
  2.滑动到最后一张引导页，点击“进入首页”按钮，判断引导页是否还存在。

  @guide_01
  Scenario: 首次安装应用，展示引导页；滑动到最后一张引导页，展示“登录/注册”和“进入首页”两个按钮
    When 展示引导页
    Then 滑动到最后一页
    Then 展示“登录/注册”和“进入首页”两个按钮
    When 点击“登录/注册”按钮
    Then 展示登录界面

  @guide_02
  Scenario: 点击最后一张引导页“进入首页”按钮，判断引导页是否还存在
    When 滑动到最后一张引导页，点击“进入首页”按钮
    Then 退出引导页
~~~

也许你现在不明白每一行，每一个关键字的含义，没关系，这个[文档](https://docs.cucumber.io/)上都有。

当然也支持全中文版的，但是感觉区分没那么明显，可以通过`cucumber --i18n-languages`语句查看支持的语言(前提是已经配置好环境)，比如中文的，在终端执行`cucumber --i18n-keywords zh-CN`:

~~~Ruby
| feature | "功能"  |
| background  | "背景"  |
| scenario  | "场景", "剧本"  |
| scenario_outline | "场景大纲", "剧本大纲"  |
| examples  | "例子"  |
| given | "* ", "假如", "假设", "假定" |
| when  | "* ", "当" |
| then  | "* ", "那么"  |
| and | "* ", "而且", "并且", "同时" |
| but | "* ", "但是"  |
| given (code)  | "假如", "假设", "假定"  |
| when (code) | "当" |
| then (code) | "那么"  |
| and (code)  | "而且", "并且", "同时"  |
| but (code)  | "但是"  |
~~~

## 4.环境配置
### Cucumber
[**Cucumber的安装和案例请参考文档，非常详细**](https://docs.cucumber.io/)

### Appium环境配置
[Appium文档](https://github.com/appium/appium/blob/master/docs/en/about-appium/getting-started.md)

[第三方博客iOS版](http://www.7forz.com/2973/)

我这里使用的**Ruby**语言编写，所以你可能需要了解下[Ruby](http://www.runoob.com/ruby/ruby-tutorial.html)的基本语法。

环境弄好了，赶紧搞个案例爽一下。

## 5.案例
### (1)、新建文件夹存放项目(AutoTestDemo)
~~~Ruby
cd Desktop
mkdir AutoTestDemo
~~~

进入 **AutoTestDemo** 目录

### (2)、初始化cucumber
~~~Ruby
cucumber --init
~~~

执行上面命令，会生成如下目录结构:

~~~Ruby
features # 存放feature的目录
├── step_definitions # 存放steps的目录
└── support # 环境配置
    └── env.rb
~~~

### (3)、创建[Gemfile](https://blog.csdn.net/efvn2008/article/details/48392047)文件

创建Gemfile文件
~~~Ruby
touch Gemfile
~~~

打开Gemfile，导入Ruby库

~~~Ruby
source 'https://www.rubygems.org'
 
gem 'appium_lib',         '~> 9.7.4'
gem 'rest-client',        '~> 2.0.2'
gem 'rspec',              '~> 3.6.0'
gem 'cucumber',           '~> 2.4.0'
gem 'rspec-expectations', '~> 3.6.0'
gem 'spec',               '~> 5.3.4'
gem 'sauce_whisk',        '~> 0.0.13'
gem 'test-unit',          '~> 2.5.5' # required for bundle exec ruby xunit_android.rb
~~~

### (4)、安装ruby依赖库
~~~Ruby
# 需要先安装bundle
gem install bundle

# 安装ruby依赖
bundle install
~~~

### (5)、新建apps目录
apps目录用于存放，被测试的app包

~~~Ruby
mkdir apps
~~~

运行目标项目，在Products文件夹中找到.app结尾的包，放到apps目录下，等待测试。

![打包app包](http://chuantu.biz/t6/328/1528940590x-1404817724.png)

### (6)、配置运行基本信息
- 1.进入features/support目录，新建appium.txt文件
- 2.编辑appium.txt文件，这里只配置了iOS的模拟器和真正代码

~~~Ruby
[caps]
# 模拟器
platformName = "ios"
deviceName = "iPhone X"
platformVersion = "11.2"
app = "./apps/AutoUITestDemo.app"
automationName = "XCUITest"
#noReset="true"

# 真机
# platformName = "ios"
# deviceName = "xxx"
# platformVersion = "10.3.3"
# app = "./apps/AutoUITestDemo.app"
# automationName = "XCUITest"
# udid = "xxxx"
# xcodeOrgId = "QT6N53BFV6"
# xcodeSigningId = "ZHH59G3WE3"
# autoAcceptAlerts = "true"  
# waitForAppScript = "$.delay(5000); $.acceptAlert();" # 处理系统弹窗

[appium_lib]
sauce_username = false
sauce_access_key = false
~~~

- 3. 打开env.rb文件，配置启动入口

~~~Ruby
# This file provides setup and common functionality across all features.  It's
# included first before every test run, and the methods provided here can be
# used in any of the step definitions used in a test.  This is a great place to
# put shared data like the location of your app, the capabilities you want to
# test with, and the setup of selenium.

require 'rspec/expectations'
require 'appium_lib'
require 'cucumber/ast'

# Create a custom World class so we don't pollute `Object` with Appium methods
class AppiumWorld
end

caps = Appium.load_appium_txt file: File.expand_path('../appium.txt', __FILE__), verbose: true
# end
Appium::Driver.new(caps, true)
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld.new
end

Before { $driver.start_driver }
After { $driver.driver_quit }
~~~

### (7)、在features目录下，新建guide.feature文件，用来描述测试用例
~~~Ruby
@guidepage
Feature: 引导页
  1.首次安装应用，判断是否展示引导页；
    滑到最后一张，判断是否展示“登录/注册”和“进入首页”两个按钮；
    点击“登录/注册”按钮，判断是否展示登录界面。
  2.滑动到最后一张引导页，点击“进入首页”按钮，判断引导页是否还存在。

  @guide_01
  Scenario: 首次安装应用，展示引导页；滑动到最后一张引导页，展示“登录/注册”和“进入首页”两个按钮
    When 展示引导页
    Then 滑动到最后一页
    Then 展示“登录/注册”和“进入首页”两个按钮
    When 点击“登录/注册”按钮
    Then 展示登录界面

  @guide_02
  Scenario: 点击最后一张引导页“进入首页”按钮，判断引导页是否还存在
    When 滑动到最后一张引导页，点击“进入首页”按钮
    Then 退出引导页
~~~


我这里写了两个测试场景，分别实测不一样的功能。测试用例写好后，我们就开始变成脚本代码了，好激动。

### (7)、在step_definitions目录下，新建guide.rb文件，用来存放脚本代码
- 在编写rb脚本之前，这里有个小技巧，就是先用`cucumber`语法运行一下项目，当然先保证Appium服务器是启动状态。
- 在终端进入项目下，执行`cucumber`命令。

![启动服务器](http://chuantu.biz/t6/328/1528940648x-1566688443.png)
![运行项目](http://chuantu.biz/t6/328/1528940678x-1566688443.png)

- 然后把终端中提示我们要实现的部分拷贝下来，放到rb文件中即可。

- 最后我们只要在里面去实现我们的业务逻辑就行啦，具体的实现代码如下：

~~~Ruby
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
~~~


- 打开终端，运行`cucumber --tags @guidepage`效果，我这里是按照[tags](https://github.com/cucumber/cucumber/wiki/Tags )来运行的。

![运行效果](http://chuantu.biz/t6/328/1528940713x-1566688443.png)

**这里所有用到的id都是需要项目源码里面去设置`accessibilityLabel`属性的**

~~~Swift
// 例如引导页和最后一页的两个按钮的id设置为：
guideView.accessibilityLabel = "Guide_Page_View"
guideView.logtinButton.accessibilityLabel = "Guide_Login_Btn"
guideView.startButton.accessibilityLabel  = "Guide_Start_Btn"

// 登录界面
view.accessibilityLabel = "login_page"
~~~

**如果某些页面定位不到可以设置属性`isAccessibilityElement`为true**

## 6.借助Appium来进行元素定位，步骤如下：
![Appium客服端点击搜索按钮](http://chuantu.biz/t6/328/1528940736x-1566688443.png)
![配置运行的信息](http://chuantu.biz/t6/328/1528940753x-1566688443.png) 
![元素定位](http://chuantu.biz/t6/328/1528940831x-1566688443.png)

## 7.源码地址

### [Swift项目源码](https://github.com/SilongLi/AutoUITestDemo)

### [测试脚本项目源码](https://github.com/SilongLi/AutoTestDemo)



