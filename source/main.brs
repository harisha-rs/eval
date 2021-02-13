sub main()
    m.screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    m.screen.setMessagePort(m.port)
    m.global = m.screen.getGlobalNode()
    m.global.addFields({
        "cart": []
    })
    m.scene = m.screen.CreateScene("MainScene")
    m.screen.show()

    while (true)
        msg = Wait(0, m.port)
        msgType = Type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub