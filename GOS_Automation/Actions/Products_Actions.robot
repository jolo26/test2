*** Settings ***
Library    String
Library    SeleniumLibrary
Resource   ../PageObjects/Products_Page.robot

*** Keywords ***
Add Items To Cart
    [Arguments]  @{items_list}
    FOR  ${item}  IN  @{items_list}
        ${item_locator}  Replace String  ${add_to_cart_var_button}  ITEM  ${item}
        Click Element  ${item_locator}
    END

Go To Shopping Cart
    Click Element  ${shopping_cart_link}

Go To Checkout
    Click Button  Checkout

Verify If Item Count Is ${count}
    Element Text Should Be    ${shopping_cart_badge_icon}    ${count}

*** Comments ***
Please place your product actions here.