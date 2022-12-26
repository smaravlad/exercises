*** Settings ***
Documentation  Test suite for verifying "www.emag.ro" functionalities.
...  Go to your favorite e-shop, navigate to some category and
...  add the two most expensive items to the shopping cart from this category. Provide code from implementation.

Library  SeleniumLibrary


*** Variables ***
${browser} =  firefox
${url} =  https://www.emag.ro
${products_in_cart} =    ${0}


*** Keywords ***
Scroll To Element And Click
    [Arguments]  ${locator}
    ${x} =  Get Horizontal Position  ${locator}
    ${y} =  Get Vertical Position  ${locator}
    ${y} =  Evaluate  ${y} - 300
    Execute Javascript  window.scrollTo(${x}, ${y})
    Click Element  ${locator}

Navigate To Laptops Category
    Click Element  xpath://span[normalize-space()='Laptop, Tablete & Telefoane']
    Click Element  xpath://a[normalize-space()='Laptopuri si accesorii']
    Click Element  xpath://a[normalize-space()='Laptopuri']

Sort Products Descending By Price
    Click Element  xpath://button[@class='btn btn-sm btn-alt sort-control-btn gtm_ejaugtrtnc']
    Click Element  xpath://a[normalize-space()='Pret descrescator']

Add Product To Cart
    [Arguments]    ${item}
    # close popup
    Run Keyword And Ignore Error  Click Element  xpath://button[@class='close']//i[@class='em em-close']
    Set Test Variable  ${stock_card}  xpath://div[@id='card_grid']/div[${item}]//div[@class='card-v2']//div[@class='card-estimate-placeholder']
    Set Test Variable  ${add_to_cart_button}  //div[@id='card_grid']/div[${item}]//div[@class='card-v2-content']//div[@class='card-v2-atc mrg-top-xxs ']//button[1]
    ${stock_information} =  Get WebElement  ${stock_card}

    Run Keyword If  '${stock_information.text}'!='stoc epuizat'
    ...  Scroll To Element And Click  ${add_to_cart_button}
    # close popup
    Run Keyword And Ignore Error  Click Element  xpath://button[@aria-label='Inchide']


*** Test Cases ***
Add 2 Most Expensive Laptops To Cart
#    [Teardown]  Close Browser

    Open Browser  url=${url}  browser=${browser}
    Maximize Browser Window

    Navigate To Laptops Category
    Sort Products Descending By Price

    FOR  ${item}  IN RANGE  1  60
        ${products_in_cart} =  Run Keyword And Ignore Error
        ...  Get WebElement  xpath://div[@class='navbar-toolbox']//div[4]//span[@class='jewel jewel-danger']
        Run Keyword And Ignore Error  Exit For Loop If  ${products_in_cart[1].text} == 2
        Add Product To Cart  ${item}
    END
