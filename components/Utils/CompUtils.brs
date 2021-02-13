function CompUtils()
    this = {
        createComponent: function(params as Object) as Dynamic
            parent = params.parent
            if parent = invalid
                comp = CreateObject("roSGNode", compType)
            else
                comp = parent.createChild(compType)
            end if
            props = params.props
            if props <> invalid and props.count() > 0
                comp.setFields(props)
            end if
            return comp
        end function
    }
    return this
end function