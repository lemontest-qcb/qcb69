*** Settings ***
Suite Setup       打开浏览器
Suite Teardown    关闭浏览器
Force Tags        suitefocetag
Library           SeleniumLibrary
Resource          mykeyword.robot

*** Test Cases ***
case1
    [Tags]    level_1
    登录erp
    进入销售出库
    ${count_row}    Get Element Count    xpath=//div[@id='tablePanel']/div/div/div[2]/div[2]/div[2]/table/tbody/tr    #默认进入是的行数
    Comment    空输入搜索
    ${count_empty_row}    关键字搜索    ${EMPTY}
    Set Global Variable    ${count_empty_row}
    Comment    关键字搜素

case2
    [Tags]    level_2
    ${count_key_row}    关键字搜索    314
    Should Not Be Equal    ${count_empty_row}    ${count_key_row}
    FOR    ${r}    IN RANGE    ${count_key_row}
        ${dj_num}    Get Text    xpath=//div[@id='tablePanel']/div/div/div[2]/div[2]/div[2]/table/tbody/tr[${r}+1]/td[4]/div
        Should Be Equal    314    ${dj_num[-3:]}
    END

case3
    Comment    不存在时搜索
    ${count_key2_row}    关键字搜索    4444444444
    Should Not Be Equal    ${count_empty_row}    ${count_key2_row}
    Should Be Equal As Integers    ${count_key2_row}    0
