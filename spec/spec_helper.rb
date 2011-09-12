require 'rubygems'
require 'bundler/setup'

require 'active_record'
require 'active_support'

require 'historical_society'

RSpec.configure do |config|

  root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "#{root}/db/historical_society.db"
  )

  ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'users'")
  ActiveRecord::Base.connection.create_table(:users) do |t|
    t.string :name
    t.datetime :deleted_at
  end

  class User < ActiveRecord::Base
    include HistoricalSociety
  end

  config.before(:each) do
    ActiveRecord::Base.connection.increment_open_transactions
    ActiveRecord::Base.connection.begin_db_transaction
  end

  config.after(:each) do
    ActiveRecord::Base.connection.rollback_db_transaction
    ActiveRecord::Base.connection.decrement_open_transactions
  end

end