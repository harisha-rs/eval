sub init()
    m.reviewList = m.top.findNode("reviewList")
    m.reviewList.itemComponentName = "ReviewComponent"
    m.reviewList.itemSize = [300, 70]
    m.reviewList.rowItemSize = [300, 40]
    m.reviewList.rowItemSpacing = [[0, 10]]
    m.reviewList.itemSpacing = [0, 10]
    m.reviewList.rowHeights = [70]
    m.reviewList.drawFocusFeedback = true
    m.reviewList.visible = true
    m.reviewList.numRows = 2
    m.top.findNode("reviewheader").font = Utils().fonts().getTimesNewRomanFont(30)
    
    m.purchase = m.top.findNode("purchase")
    m.purchase.observeField("buttonSelected", "onPurchasePress")

    m.store = CreateObject("roSGNode", "ChannelStore")
    m.store.fakeServer = true
    m.store.id = "store"
    m.store.observeField("catalog", "onGetCatalog")
    m.store.ObserveField("purchases", "onGetPurchases")
    m.store.observeField("orderStatus", "onOrderStatus")
    
    m.store.command = "getCatalog"
end sub

sub onPurchasePress()
'    ? ">>>> ON PURCHASE SELECTED <<<<"
    myOrder = CreateObject("roSGNode", "ContentNode")
    myFirstItem = myOrder.createChild("ContentNode")
    myFirstItem.addFields({ "code": "TS1",name:"Harisha Product", "qty": 1 })
    m.orderType =  "purchase"
    m.store.order = myOrder
    m.store.command = "doOrder"
end sub

function onOrderStatus(msg as Object)
    status = msg.getData().status
    tid =  msg.getData().purchaseId
    if status = 1 ' order success
        ? "> order success"
        tid = m.store.orderStatus.getChild(0).purchaseId
        ' validate the order by checking if it is now entitled on the roku side
'        ? "tid= "; tid
    else ' error in doing order
'        ? "> order error . .."
'        ? "> error status " status ": " msg.getData().statusMessage
        m.store.order = invalid ' clear order
    end if

    orderResult = { status: status, tid: tid }
'    m.top.purchaseResult = orderResult
    if m.orderType =  "purchase"
        dialog = CreateObject("roSGNode","Dialog")
        dialog.visible = true
        dialog.buttons = ["Ok"]
        dialog.message = "You Purchase Was Successful, Press Ok continue."
        dialog.title = "Success"
        
        m.top.getParent().getParent().callFunc("userLoggedInSuccessfully")
    else if m.orderType = "upgrade"
        m.top.upgradeResult = orderResult
    else
        m.top.purchaseResult = orderResult
        ? "Error - can't happen, orderType= "; orderType
    end if
    m.orderType = ""
end function

function onGetCatalog(event)
    ? "onGetCatalog"
    catalogData = m.store.catalog
    productList = catalogdata.getChildren(catalogdata.getChildCount(), 0)
    content = CreateObject("roSGNode", "ContentNode")
    shelfNode = content.createChild("ContentNode")
    for each product in productList
        shelfNode.appendChild(product)
'        ? "product= "; product
    end for
end function

sub setReviews(evt)
    parentNode = CreateObject("roSGNode", "ContentNode")
'    ? ">>>> INSIDE SE REVIEWS <<<<"
    for each review in evt.getData()
        shelfNode = parentNode.createChild("ContentNode")
        item = shelfNode.createChild("ContentNode")
'        ? ">>>> REVIEW TITLE "; review.title; " <<<<<"
        item.addFields({
            title: review.title
            desc: review.desc
        })
    end for

    m.reviewList.content = parentNode
end sub

function onKeyEvent(key, press) as Boolean
    if press
        if key = "right"
            m.reviewList.setFocus(true)
            return true
        else if key = "left"
            m.purchase.setFocus(true)
            return true
        end if
    end if
    return false
end function