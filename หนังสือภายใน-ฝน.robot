*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
จนท.จัดทำหนังสือนำ และยกร่างหนังสือบันทึกข้อความ ออกเลขทั่วไป มีชั้นความลับ ไม่มีความเร่งด่วน เสนอ ผู้อํานวยการสำนัก/กอง/กลุ่ม/ศูนย์ ลงนาม
    เปิด Chrome Browser เข้าระบบ E-office
    เข้าสู่ระบบ    sunisa.ra    P@ssw0rd    
    เข้าเมนูระบบสารบรรณ
    เข้าเมนูยกร่างหนังสือ
    กรอกข้อมูลหนังสือส่ง
    กดปุ่มออกเลขหนังสือ
    กดปุ่มเสนอ
    เลือกรายการที่จะเสนอ    หัวหน้ากลุ่มวิเคราะห์ข้อมูลการเสียภาษีเงินได้บุคคลธรรมดา (นางสาวกนกพร ดีหลายศรี) 
    รอจนเสนอเสร็จเเละปิด browser

*** Keywords ***
เปิด Chrome Browser เข้าระบบ E-office
    Open Browser    url=https://rd-dev.summitthai.com/rd-app/login.xhtml    browser=chrome

เข้าสู่ระบบ
    [Arguments]    ${userId}    ${password}
    Input Text    id=form-login:userId    ${userId}
    Input Text    id=form-login:password    ${password}
    Click Element    id=form-login:btn

เข้าเมนูระบบสารบรรณ
    Click Link    //*[@id="menuform:j_idt163_0"]/a

เข้าเมนูยกร่างหนังสือ
    Click Link    //*[@id="menuform:j_idt163_1"]/a
    Click Link    //*[@id="menuform:j_idt163_1_1"]/a

กรอกข้อมูลหนังสือส่ง
    #ลงวันที่
    Click Element    id=formc:bookDate1_input
    Click Element    //*[@id="ui-datepicker-div"]/div/div/select[1]
    Click Element    //*[@id="ui-datepicker-div"]/div/div/select[1]/option[6]
    Click Element    //*[@id="ui-datepicker-div"]/table/tbody/tr[3]/td[5]/a 
    #เรื่อง
    Input Text    id=formc:subject1    หนังสือประชาสัมพันะการยื่นแบบแสดงรายการภาษีเงินได้บุคคลธรรมดา ปีภาษี 2563
    #เรียน
    Input Text    id=formc:receiverNameAuto1_input    ผู้อำนวยการกองมาตรฐานการจัดเก็บภาษี
    Wait Until Element Is Visible    id=formc:receiverNameAuto1_panel
    Click Element    //*[@id="formc:receiverNameAuto1_panel"]/ul/li[contains(@data-item-label, 'ผู้อำนวยการกองมาตรฐานการจัดเก็บภาษี')]
   
กดปุ่มออกเลขหนังสือ
    Click Element    id=formc:e_btnInsert 

กดปุ่มเสนอ
    Wait Until Page Contains Element    id=formc:btnOfferS
    Scroll Element Into View    id=formc:btnOfferS
    Execute JavaScript    window.scrollTo(window.scrollX, window.scrollY + 100)
    Click Element    id=formc:btnOfferS 

เลือกรายการที่จะเสนอ
    [Arguments]    ${purposeName}
    Wait Until Page Contains Element    id=formc:chkGetManager1_2_P
    Scroll Element Into View    //*[@id="formc:chkGetManager1_2_P"]/tbody/tr[./td/label[contains(text(), '${purposeName}')]]
    Execute JavaScript    window.scrollTo(window.scrollX, window.scrollY + 100)
    Click Element    //*[@id="formc:chkGetManager1_2_P"]/tbody/tr[./td/label[contains(text(), '${purposeName}')]]//div[contains(@class, "ui-chkbox")]
    
กดปุ่มเพิ่อเสนอ
    Click Element    id=formc:e_btnAddSendLetter1

รอจนเสนอเสร็จเเละปิด browser
    Wait For Condition    style = document.querySelectorAll("[id*='_start']")[0].style; return style.display == "none"
    Close All Browsers
