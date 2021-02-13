sub init()
    m.mainMenu = m.top.findNode("mainMenu")
    m.mainMenu.observeField("rowItemSelected", "onMenuItemSelected")
    m.screens = m.top.findNode("screens")
    createMainMenu()
end sub

sub createMainMenu()
    m.menuTitles = ["Furnitures", "Clothing", "Phone", "Electronics", "My Cart"]
    parentNode = CreateObject("roSGNode", "ContentNode")
    shelfNode = parentNode.createChild("ContentNode")
    i = 0
    for each menuTitle in m.menuTitles
        item = shelfNode.createChild("ContentNode")
        item.addFields({
            title: menuTitle
            id: i
        })
        i += 1
    end for

    m.mainMenu.itemComponentName = "MenuComponent"
    m.mainMenu.itemSize = [1500, 50]
    m.mainMenu.rowItemSize = [250, 50]
    m.mainMenu.rowHeights = [50]
    m.mainMenu.rowItemSpacing = [[10, 0]]
    m.mainMenu.itemSpacing = [10, 0]
    m.mainMenu.content = parentNode
    m.mainMenu.drawFocusFeedback = false
    m.mainMenu.setFocus(true)

    generateScreenData()
    m.homeScreen = m.screens.createChild("HomeScreen")
    m.productList =  m.homeScreen.findNode("productList")
    m.productList.content = m.data[0]
end sub

sub onMenuItemSelected(evt)
    selectedIndex = m.mainMenu.rowItemSelected[1]
    if selectedIndex = 4
        ?">>>> POPULATING FAV <<< ";m.global.cart.Count()
        content = CreateObject("roSGNode", "ContentNode")
        shelfNode = content.createChild("ContentNode")
        for each fav in m.global.cart
            shelfNode.appendChild(fav)
        end for
    else
        content = m.data[m.mainMenu.rowItemSelected[1]]
    end if
    m.productList.content = content
    m.productList.setFocus(true)
end sub

sub generateScreenData()
    m.prodReviews = ["Good purchase", "Happy to buy this", "Certainly Recommend", "Good purchase", "Happy to buy this", "Certainly Recommend"]

    m.data = []

    for each menuItem in m.menuTitles
        parentNode = CreateObject("roSGNode", "ContentNode")
        shelfNode = parentNode.createChild("ContentNode")
        shelfNode.title = menuItem
        for i = 0 to 5 step 1
            item = shelfNode.createChild("ContentNode")
            item.addFields({
                title: "title " + (i + 1).toStr()
                desc: "desc " + (i + 1).toStr()
                rating: "4.5"
                price: (i + 1) * 10
                code: "TS1"
                imageUrl: "https://source.unsplash.com/random/200x200?sig=" + i.toStr()
                inCart: false
                reviews: [
                    {
                        title: m.prodReviews[i]
                        desc: "Review desc " + (i + 1).toStr()
                    },
                    {
                        title: m.prodReviews[i + 1]
                        desc: "Review desc " + (i + 2).toStr()
                    },
                    {
                        title: m.prodReviews[i + 2]
                        desc: "Review desc " + (i + 3).toStr()
                    },
                    {
                        title: m.prodReviews[i + 3]
                        desc: "Review desc " + (i + 4).toStr()
                    }
                ]
            })
        end for
        m.data.Push(parentNode)
    end for
end sub

function onKeyEvent(key, press) as Boolean
    if press
        if key = "up"
            m.mainMenu.setFocus(true)
            return true
        else if key = "down"
            m.productList.setFocus(true)
            return true
        end if
    end if
    return false
end function