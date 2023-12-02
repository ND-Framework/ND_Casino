local prices = {}

prices.chips = 5 -- each chip costs 5 dollars.

prices.membership = {
    {
        label = "1 day",
        expiresInHours = 24,
        price = 500
    },
    {
        label = "1 week",
        expiresInHours = 168,
        price = 2000
    },
    {
        label = "1 month",
        expiresInHours = 730,
        price = 5000
    },
    {
        label = "lifetime",
        expiresInHours = 90000,
        price = 25000
    }
}

return prices
