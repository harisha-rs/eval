function Utils()
    this = {
        fonts: function()
            this = {
                getTimesNewRomanFont: function(size)
                    font = CreateObject("roSGNode", "font")
                    font.uri = "pkg://fonts/times-new-roman.ttf"
                    font.size = size

                    return font
                end function
            }
            return this
        end function,
    }
    return this
end function

