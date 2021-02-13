sub init()
    m.title = m.top.findNode("title")
end sub

sub onContentSet(evt)
    contentNode = m.top.itemContent
    m.title.text = contentNode.title
end sub