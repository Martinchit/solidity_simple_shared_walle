# Shared Wallet

## Introduction

It is a simple shared wallet smart contract built with solidity 0.6.0.

Development is done on [Remix IDE](http://remix.ethereum.org/) with JavaScript VM for gas usage

## Features

- Contract owner can assign allowance to different account

- Contract owner / whitelisted account can withdraw a certain amount of ether

- Contract owner can remove whitelisted account

- Contract owner / whitelisted account can check their allowance balance

## Package Used

- [Ownable](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol)

- [SafeMath](https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol)