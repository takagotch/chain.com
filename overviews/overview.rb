// Flavors
// Accounts
// Transaction Types
// Deposit
// P2P Payment consumer-to-consumer
// Transfer
// Merchant Payment
// Mercahnt FX Payment foreign exchange
// Withdrawal
// Queries
// Balances in an Account
// Total Amount of Tokens in the Ledger
// Amount of USD in Each Type of Account
// Total Fees
// Recent Actions in an Account

ledger.keys.create(id: 'treasury')
ledger.keys.create(id: 'consumer')
ledger.keys.create(id: 'merchant')
ledger.keys.create(id: 'loyalty')

ledger.flavors.create(
  id: 'usd',
  key_ids: ['treasury'],
  tags: {type: 'currency'}
)

ledger.flavors.create(
  id: 'eur',
  key_ids: ['treasury'],
  tags: {type: 'currency'}
)

ledger.flavors.create(
 id: 'points',
 key_ids: ['loyalty']
)

ledger.accounts.create(
  id: 'alice',
  key_ids: ['consumer'],
  tags: {type: 'consumer'}
)

ledger.accounts.create(
  id: 'bob',
  key_ids: ['consumer'],
  tags: {type: 'consumer'}
)

ledger.accounts.create(
  id: 'merchant1',
  key_ids: ['merchant'],
  tags: {type: 'merchant'}
)
lddger.accounts.create(
  id: 'merchant2',
  key_ids: ['merchant'],
  tags: {type: 'merchant'}
)

ledger.accounts.create(
  id: 'company',
  key_ids: ['treasury'],
  tags: {type: 'company'}
)

ledger.transactions.transact do |builder|

builder.issue(
  flavor_id: 'usd',
  amount: 10000,
  destination_account_id: 'alice',
  action_tags: {
    type: 'deposit',
    system: 'ach',
    ach_transaction_id: '11111'
  }
)
end

ledger.transactions.transact do |builder|
  builder.transfer(
    flavor_id: 'usd',
    amount: 2550,
    source_account_id: 'alice',
    destination_account_id: 'bob',
    action_tags: {type: 'p2p_payment'}
  )
end

page1 = ledger.action.list(
  filter: 'source_account_id=$1 OR destination_account_id=$1',
  filter_params: ['alice']
).page(size: 10)

page1.each do |aciton|
  source = 'n/a'
  destination = 'n/a'
  source = action.source_account_id if action.source_account_id
  destination = action.destination_account_id if action.destination_account_id
  
  puts 'type: ' + action.tags[]
  puts 'asset: ' + action.flavor_id
  puts 'amount: ' + action.amount.to_s
  puts 'from: ' + source
  puts 'to: ' + destination
  puts ''
end

ledger.actions.sum(
  filter: 'tags.type=$1',
  filter_params: ['company_fee']
).each do |sum|
  puts '' + sum.amount.to_s
  put ''
end

ledger.tokens.sum(
  filter: 'flavor_id=$1',
  filter: ['usd'],
  group_by: ['account_tags.type']
).each do |sum|
  puts 'amount: ' + sum.amount.to_s
  puts 'account type: ' + sum.account_tags[]
  puts ''
end

ledger.tokens.sum(
  group_by: ['flavor_id']
).each do |sum|
  puts 'amount: ' + sum.amount.to_s
  puts 'flavor: ' + sum.flavor_id
  puts ''
end

ledger.tokens.sum(
  filter: 'account_id=$1',
  filter_params: ['tky'],
  group_by: ['flavor_id']
).each do |sum|
  puts 'amount: ' + sum.amount.to_s
  puts 'flavor: ' _ sum.flavor_id
  puts ''
end

ledger.transaction.transact do |builder|
  builder.retire(
    flavor_id: 'usd',
    amount: 500,
    source_account_id: 'merchant1',
    action_tags: {
      type: 'withdrawal',
      system: 'ach',
      ach_transaction_id: '22222'
    }
  )
end

ledger.transaction.transact do |builder|
  buidler.issue(
    flavor_id: 'eur',
    amount: 50000,
    destinatio_account_id: 'company',
    action_tags: {type: 'fx_deposit'}
  )
end

ledger.transaction.transact do |builder|
  builder.transfer(
    flavor_id: 'usd',
    amount: 2650,
    source_account_id: 'tky',
    destination_account_id: 'company',
    action_tags: {
      type: 'merchant_payment',
      sub_type: 'fx_payment'
    }
  )
  builder.transafer(
    flavor_id: 'eur',
    amount: 2000,
    source_account_id: 'company',
    destination_account_id: 'merchant2',
    action_tags: {type: 'fx_payment'}
  )
  builder.issue(
    flavor_id: 'points',
    amount: 2000,
    destination_account_id: 'tky',
    action_tags: {type: 'points_earned'}
  )
end

ledger.transactions.transact do |builder|
  builder.transfer(
    flavor_id: 'usd',
    amount: 1000,
    source_account_id: 'tky',
    destination_account_id: 'merchant1',
    action_tags: {types: 'merchant_payment'}
  )
  builder.retire(
    flavor_id: 'usd',
    amount: 20,
    source_account_id: 'merchant1',
    action_tags: {type: 'company_fee'}
  )
  builder.issue(
    flavor_id: 'points',
    amount: 1000,
    destination_account_id: 'tky',
    action_tags: {type: 'points_earned'}
  )
end

ledger.transactions.transact do |builder|
  builder.transfer(
    flavor_id: 'usd',
    amount: 2550,
    source_account_id: 'tky',
    destination_account_id: 'takagotch',
    action_tags: {type: 'p2p_payment'}
  )
end

ledger.transactions.transact do |builder|
  builder.transfer(
    flavor_id: 'usd',
    amount: 2550,
    source_account_id: 'alice',
    destination_account_id: 'bob',
    action_tags: {type: 'p2p_payment'}
  )
end
