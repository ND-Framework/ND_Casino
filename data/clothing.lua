-- this will create a clothing store in the casino, it requires the ND_AppearanceShops resource
return {
    price = 500,
    text = "Change clothes",
    appearance = {
        components = true,
        props = true,
    },
    blip = {
        label = "Clothing store",
        sprite = 73,
        scale = 0.8,
        color = 0,
        showWhenNear = true
    },
    locations = {
        {
            model = `u_f_m_casinoshop_01`,
            worker = vec4(1100.60, 195.65, -49.44, 317.30),
            change = vec4(1096.31, 201.21, -49.44, 222.96)
        }
    }
}
