*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
打开浏览器
    [Arguments]    ${browser}=gc
    Open Browser    http://erp.lemfix.com/    ${browser}
    Maximize Browser Window    #最大化浏览器

进入iframe
    [Arguments]    ${c}
    [Documentation]    通过页面的数字，来获得id，再生成iframeid值，最后进入iframe里面
    ${id_num}    Get Element Attribute    xpath=//div[@id='tabpanel']/div/div[1]/div[3]/ul/li[${c}]    id    #获取页面元素的属性值
    ${iframeid}    Set Variable    ${id_num}-frame
    Select Frame    ${iframeid}    #切换到iframe中

关闭浏览器
    Delete All Cookies
    Close All Browsers

关键字搜索
    [Arguments]    ${sec_key}
    ${key}    Set Variable    ${sec_key}
    Clear Element Text    searchNumber
    Input Text    searchNumber    ${key}    #在文本框中输入 314
    Click Element    searchBtn    #点击查询按钮
    Sleep    2
    ${count_key_row}    Get Element Count    xpath=//div[@id='tablePanel']/div/div/div[2]/div[2]/div[2]/table/tbody/tr
    [Return]    ${count_key_row}

登录erp
    Title Should Be    柠檬ERP
    Input Text    username    test123    #登录账户文本框中输入 test123
    Input Password    password    123456    #输入密码
    Click Element    xpath=//body/div/div/div[2]/div[3]/div/label[1]/div/ins    #选中记住账户
    Click Element    btnSubmit    #点击立即登录
    Sleep    2
    Wait Until Element Is Visible    xpath=/html/body/div[1]/header/nav/div[1]/b    3
    ${staus}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=/html/body/div[1]/header/nav/div[1]/b    3    #等待超时时间未3秒
    Run Keyword If    ${staus}    log    登录成功
    ...    ELSE    Log    登录失败

进入销售出库
    Click Element    xpath=//*[@id="leftMenu"]/ul/li[1]/ul/li[1]    #点击零售出库
    sleep    5
    进入iframe    2
