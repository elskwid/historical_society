history -- Preserve the history of your data, starting with soft delete.
====================================

## DESCRIPTION

history currently provides basic soft delete functionality on an ActiveRecord instance through the use
of a "deleted_at" timestamp column and a default_scope that excludes the soft deleted records.

_Note: This currently provides a default_scope that excludes soft deleted records.  It also overrides
the normal #destroy and #delete instance methods so they just set the deleted_at timestamp without
actually deleting the records from the db._

## INSTALLATION

  $  gem install history

## USAGE

In your model:

  class User < ActiveRecord::Base
    include History
  end

In your queries:

  User.all          # does not include deleted records
  User.unscoped.all # includes deleted records

  User.find(1)           # raises ActiveRecord::RecordNotFound if user has been soft deleted
  User.unscoped.find(1)  # finds user record regardless of soft deletion

In relationships:

  @account.users  # finds only users within the account scope that have not been soft deleted
  @account.users.unscoped # CAREFUL! THIS REMOVES THE ACCOUNT SCOPE TOO!

  # THIS IS PROBABLY WHAT YOU WANT
  # Removes the default scope on user, but then adds the account scope through an explicit where method.

  User.unscoped.all.where(:account_id => @account.id)


