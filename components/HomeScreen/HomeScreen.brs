sub init()
    m.productList = m.top.findNode("productList")
    m.productInfo = m.top.findNode("productInfo")
    m.font_TNR_30 =  Utils().fonts().getTimesNewRomanFont(30)
    m.font_TNR_40 =  Utils().fonts().getTimesNewRomanFont(40)
    m.productList.itemSize = [1920, 200]
    m.productList.rowItemSize = [300, 150]
    m.productList.itemComponentName = "ProductComponent"
    m.productList.rowItemSpacing = [[25, 0]]
    m.productList.itemSpacing = [10, 0]
    m.productList.rowHeights = [200]
    m.productList.drawFocusFeedback = true
    m.productList.visible = true
    m.productList.rowLabelOffset = [0, 20]
    m.productList.showRowLabel = true
    m.productList.rowLabelFont = m.font_TNR_30
    m.productList.rowFocusAnimationStyle = "fixedFocusWrap"
    m.productList.observeField("rowItemFocused", "onProductFocused")

    m.focusableKeys = ["productList", "productInfo"]
    m.productInfo.translation = [0, 330]

    m.focusedKey = 0
end sub

sub onProductFocused(evt)
    selectedIndex = evt.getData()[1]
'    ? ">>>> ON ITEM FOCUSED "; evt.getData(); " <<<<<"
    m.product = m.productList.content.getChild(0).getChild(selectedIndex)
    m.productInfo.visible = true
    m.productInfo.title = "Title: " + m.product.Title
    m.productInfo.desc = "Description " + m.product.desc
    m.productInfo.rating = "Rating: " + m.product.rating.ToStr()
    m.productInfo.price = "Price " + m.product.price.ToStr()
    m.productInfo.image = m.product.imageUrl
    m.productInfo.code = m.product.code
    m.productInfo.reviews = m.product.reviews
    m.productInfo.compTitle = "Product Details."
    m.productInfo.font = m.font_TNR_30
end sub

sub updateFocus()
    comp = m.top.findNode(m.focusableKeys[m.focusedKey])
    if comp.id = "productInfo"
        comp.findNode("purchase").setFocus(true)
    end if
    comp.setFocus(true)
end sub

function onKeyEvent(key, press) as Boolean
    ?">>>>> FOCUS KEY <<<<<"; m.focusedKey
    if press
        if key = "down"
            if m.focusedKey < m.focusableKeys.count() - 1
                m.focusedKey += 1
                updateFocus()
                return true
            end if
        else if key = "up"
            if m.focusedKey > 0
                m.focusedKey -= 1
                updateFocus()
                return true
            else
                return false
            end if
        else if key = "options"
            ?">>>> ADDED TO FAV <<<"
            m.global.cart.Push(m.product)
            ?">>> TOTAL FAVB IN CART ";m.global.cart.count();" <<<<"
        end if
    end if
    return false
end function