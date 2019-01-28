Transaction Mapper
===============
Ruby CLI for categorizing transactions.

Currently only supports American Express transactions.
Ths script will create a new csv with your categorized transactions.
It will also list out all of your transactions that failed to be categorized.

There is a simple mapping.json file that lists mappings. Feel free to update it
to better categorize your transactions.

## Requirements

Ruby 2.6.0

## Instructions

clone this repo:

```sh
$ git clone git@github.com:mgreg90/transaction_mapper.git
```

bundle dependencies

```sh
$ bundle
```

make the script executable
```sh
$ chmod u+x bin/map-transactions
```

execute and pass the path to your card activity csv from Amex

```sh
$ bin/map-transactions ~/Downloads/ofx.csv
```

## TODO

* Create a way to add mappings to mappings.json from CLI.
* Add tool to import transactions directly from Amex. (Possibly using this gem: https://rubygems.org/gems/amex)
* Support CLI argument to select a specific month's transactions.