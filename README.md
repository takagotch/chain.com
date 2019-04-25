### chain.com
---
https://chain.com/

```java
Account.Page page1 = mew Account.ListBuilder()
  .setFilter("tag.type=$1")
  .addFilterParameter("checking")
  .setPageSize(10)
  .getPage(ledger);
for (Account account : page1.items) {
}

String cursor = page1.cursor;

Account.Page page2 = new Account.ListBuilder()
  .getPage(ledger, cursor);
for (Account account : page2.items) {
}

Transaction.Page page1 = new Transaction.ListBuilder()
  .setFilter("actions(sourceAccountId=$1 OR destinationAccountId=$1)")
  .addFilterParameter("alice")
  .setPageSize(10)
  .getPage(ledger);
for (Transaction tx : page.items) {
}

String cursor = page1.cursor;

Transaction.Page page2 = new Transaction.ListBuilder()
  .getPage(ledger, cursor);
for (Transaction tx : page2.items) {
}

Action.Page page1 = new Actin.ListBuilder()
  .setFilter("destinationAccountId=$1 AND flavorId=$2 AND type=$3")
  .addFilterParameter("alice")
  .addFilterParameter("usd")
  .addFilterParameter("issue")
  .setPageSize(10)
  .getPage(ledger);
for (Action action : page1.items) {
}

String cursor = page1.cursor;

Action.Page page2 = new Action.ListBuilder()
  .getPage(ledger, cursor);
for (Action action : page2.item) {
}

TokenGroup.Page page1 = new Token.ListBuilder()
  .setFilter("tags.due=$1")
  .addFilterParameter("date")
  .setPageSize(10)
  .getPage(ledger);
for (TokenGroup tokenGroup : page1.items) {
}

String cursor = page1.cursor;

TokenGroup.Page page2 = new Token.ListBuilder()
  .getPage(ledger, cursor);
for (TokenGroup tokenGroup : page2.items) {
}
```

```ruby
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

```

