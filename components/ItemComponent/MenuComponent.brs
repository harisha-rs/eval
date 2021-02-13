sub init()
    m.title = m.top.findNode("title")
    m.menuBGColor = m.top.findNode("menuBGColor")

    m.font_TRN_30 = Utils().fonts().getTimesNewRomanFont(30)
    m.font_TRN_40 = Utils().fonts().getTimesNewRomanFont(40)
end sub

sub onContentSet(evt)
    m.menuBGColor.color = "#FFFFFF"
    m.title.color = "#FFFFFF"
    m.title.font = m.font_TRN_30
    m.title.Text = m.top.itemContent.title
'    ? " >>>> ON CONTENT SET onContentSet()"; evt.getData()
end sub

sub onFocusPercentChange()
    m.menuBGColor.opacity = m.top.focusPercent
    if m.top.focusPercent < 0.1
        m.menuBGColor.opacity = 0
        m.title.color = "#FFFFFF"
    else if m.top.focusPercent > 0.9
        m.menuBGColor.opacity = 1
        m.title.color = "#000000"
    end if
end sub

sub onItemFocusChange()
    itemHasFocus = m.top.itemHasFocus
    if itemHasFocus
        m.title.font = m.font_TRN_40
        m.title.color = "#000000"
    else
        m.title.font = m.font_TRN_30
        m.title.color = "#FFFFFF"
    end if
end sub

sub onRowFocusChange()
    rowListHasFocus = m.top.itemHasFocus
    if not rowListHasFocus
        m.menuBGColor.opacity = 0.6
    else
        m.menuBGColor.opacity = 1
    end if
end sub