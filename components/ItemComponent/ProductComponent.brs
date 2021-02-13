sub init()
    m.productImage = m.top.findNode("productImage")
    m.productTitle = m.top.findNode("productTitle")
    m.productTitleBG = m.top.findNode("productTitleBG")
end sub

sub onContentSet(evt)
'    ? " >>>> ON CONTENT SET onContentSet() Product Component"; evt.getData()
    ?">>>> PRODUCT TITLE ";m.top.itemContent.title;" <<<<<"
    setAndArrange()
    m.productImage.uri = m.top.itemContent.imageUrl
    m.productTitle.text = m.top.itemContent.title
end sub

sub setAndArrange()
    ? ">>>> HEIGHT "; m.top.height; " WIDTH "; m.top.width; " <<<<<"
    m.productImage.loadHeight = m.top.height
    m.productImage.loadWidth = m.top.width
    m.productImage.loadDisplayMode = "ScaleToFill"
    m.productTitle.font = Utils().fonts().getTimesNewRomanFont(20)
    m.productTitleBG.translation = [20, 100]
'    productTitle.
    m.productTitle.height = 50
    m.productTitle.width = 300
    m.productTitleBG.height = 30
    m.productTitleBG.width = 260
end sub

sub onRowFocusChange()
end sub
