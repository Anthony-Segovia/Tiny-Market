# Tiny-Market

Features

Tiny Market is a minimal implementation marketplace that allows people to trustlessly list NFTs for sale. An NFT offering will contain the following information:

The NFT being offered for sale.
A block height at which the listing expires.
The payment asset, either STX or a SIP010 fungible token. This allows the seller to request payment in a fungible token other than STX.
The NFT price in said payment asset.
An optional intended taker. If set, only that principal will be able to fulfil the listing. This is useful if someone found a buyer outside of the platform and wants to trustlessly conduct a trade with just that person.
There will be no bidding or other matters that complicate the project. A listing is created by calling into the marketplace contract with the above information. The contract will then transfer the NFT and keep it in escrow for the duration of the listing. The seller can at any point decide to cancel the listing and retrieve the NFT. If someone decides to purchase the NFT, the marketplace will atomically take the payment from the buyer and transfer the NFT. Once a listing has expired, only the seller will be able to retrieve the NFT from the marketplace.
