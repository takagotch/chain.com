// Issue tokens
// Transfer tokens
//

tx = ledger.transactions.transact do |builder|
  builder.issue(
    flavor_id: 'usd',
    amount: 100,
    destination_account_id: 'tky'
  )
end


tx = ledger.transactions.transact do |builder|
  builder.issue(
    flavor_id: 'debt',
    amount: 100,
    destination_account_id: 'tky',
    token_tags: {due: 'Dec2019'}
  )
end

tx = ledger.transactions.transact do |builder|
  builder.transfer(
    flavor_id: 'usd',
    amount: 100,
    source_account_id: 'tky',
    destination_account_id: 'takagotch'
  )
end

tx = ledger.transactions.transact do |builder|
  builder.transfer(
    flavor_id: 'debt',
    amount: 20,
    source_account_id: 'tky',
    destination_account_id: 'takagotch',
    filter: 'tags.due=$1',
    filter_params: ['Dec2019'],
    token_tags: {due: 'Feb2019'}
  )
end

tx = ledger.transactions.transact do |builder|
  builder.retire(
    flavor_id: 'usd',
    amount: 5,
    source_account_id: 'tky'
  )
end

tx = ledger.transactions.transactions.transact do |builder|
  builder.retire(
    flavor_id: 'debt',
    amount: 80,
    source_account_id: 'tky',
    filter: 'tags.due=$1',
    filter_params: ['Dec2019']
  )
end

page1 = ledger.tokens.sum(
  filter: 'account_id=$1',
  filter_params: ['tky'],
  group_by: ['flavor_id'],
).page(size: 10)

page1.each do |balance|
  puts 'amount: ', balance.amount
  puts 'flavor: ', balance.flavor_id
end

cursor = page1.cursor

page2 = ledger.tokens.sum.page(cursor: cursor)

page2.each do |balance|
  puts 'amount: ', balance.amount
  puts 'flavor: ', balance.flavor_id
end

page1 = ledger.tokens.list(
  filter: 'account_id=$1',
  filter_params: ['alice'],
).page(size: 10)

page1.each do |group|
  puts group.to_json
end

cursor = page1.cursor

page2 = ledger.tokens.list.page(cursor: cursor)

page2.each do |group|
  puts group.to_json
end













