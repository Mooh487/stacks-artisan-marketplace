# Stacks Artisan Marketplace

## Overview
The Stacks Artisan Marketplace is a decentralized application built on the Stacks blockchain. It provides a platform for artisans to register, list their craft items for sale, and for buyers to purchase these items securely and transparently. The marketplace operates with a customizable platform fee, which supports operational and development costs.

## Features
- **Artisan Registration and Verification**: Artisans can register and update their profiles, and the contract owner can verify them.
- **Craft Item Listing and Management**: Artisans can list, update, and delist their craft items.
- **Secure Transactions**: Buyers can purchase items, with funds distributed to the artisan and the platform.
- **Platform Fee Management**: The platform fee is adjustable by the contract owner.
- **Event Logging**: Key actions like artisan registration and item listing are logged for transparency.

---

## Table of Contents
1. [Smart Contract Functions](#smart-contract-functions)
    - [Public Functions](#public-functions)
    - [Read-Only Functions](#read-only-functions)
2. [Error Codes](#error-codes)
3. [Usage Guide](#usage-guide)
    - [Registering as an Artisan](#registering-as-an-artisan)
    - [Listing a Craft Item](#listing-a-craft-item)
    - [Buying an Item](#buying-an-item)
    - [Managing Platform Fee](#managing-platform-fee)
4. [Development](#development)
5. [License](#license)

---

## Smart Contract Functions

### Public Functions
1. **`register-artisan(name, description)`**
   - Registers an artisan with a name and description.
   - Emits an event upon successful registration.

2. **`update-artisan-info(name, description)`**
   - Updates the artisan's profile information.

3. **`verify-artisan(artisan)`**
   - Verifies an artisan. Only the contract owner can perform this action.

4. **`list-craft-item(name, description, price, image-url)`**
   - Lists a craft item for sale with details including price and image URL.

5. **`update-craft-item(item-id, name, description, price, image-url)`**
   - Updates the details of a listed craft item.
   - Only the artisan who created the item can update it.

6. **`delist-craft-item(item-id)`**
   - Removes a craft item from the marketplace.
   - Only the artisan who created the item can delist it.

7. **`purchase-craft-item(item-id)`**
   - Allows a buyer to purchase a craft item, transferring the price minus the platform fee to the artisan.

8. **`change-platform-fee(new-fee)`**
   - Updates the platform fee percentage.
   - Only the contract owner can perform this action.

9. **`withdraw-funds(amount)`**
   - Allows an artisan to withdraw funds after a sale.

### Read-Only Functions
1. **`get-artisan(wallet)`**
   - Fetches details of an artisan using their wallet address.

2. **`get-craft-item(item-id)`**
   - Retrieves details of a craft item by its ID.

3. **`get-platform-fee()`**
   - Returns the current platform fee percentage.

---

## Error Codes
- `u100`: Not the contract owner.
- `u101`: Artisan is already registered.
- `u102`: Artisan is not registered.
- `u103`: Item not found.
- `u104`: Item already sold.
- `u105`: Insufficient funds for purchase or withdrawal.
- `u404`: Not found.
- `u500`: Item is already sold.
- `u600`: Invalid input provided.
- `u601`: Platform fee exceeds 100%.
- `u602`: Zero price provided for item.

---

## Usage Guide

### Registering as an Artisan
1. Call the `register-artisan` function with your name and description.
2. Once registered, you can update your profile with `update-artisan-info`.

### Listing a Craft Item
1. Ensure you are registered as an artisan.
2. Use the `list-craft-item` function with the item's name, description, price, and image URL.
3. Retrieve the `item-id` from the response for future updates or delisting.

### Buying an Item
1. Call the `purchase-craft-item` function with the item's `item-id`.
2. Ensure your wallet has sufficient STX to cover the item's price.

### Managing Platform Fee
1. Only the contract owner can call the `change-platform-fee` function.
2. Provide a `new-fee` value between 0 and 100.

---

## Development

### Requirements
- [Stacks CLI](https://docs.stacks.co/build-tools/cli)
- Clarity Language Knowledge

### Deploying the Contract
1. Clone this repository.
2. Compile the contract using the Stacks CLI.
3. Deploy to your desired Stacks testnet or mainnet environment.

---

## License
This project is licensed under the MIT License. You are free to use, modify, and distribute this code as per the license terms.
