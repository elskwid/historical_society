require 'spec_helper'
describe User do

  describe "User queries with paranoia" do
    let!(:user) { User.create(:name => "Bob") }
    let!(:deleted_user) { User.create(:name => "Steve", :deleted_at => 5.minutes.ago) }

    it "should be in default scope" do
      User.all.should include(user)
    end

    it "should not include undeleted user" do
      User.all.should_not include(deleted_user)
    end

    it "should have deleted users in unscoped queries" do
      User.unscoped.all.should include(user)
      User.unscoped.all.should include(deleted_user)
    end
  end

  describe "User deletion with paranoia" do
    let!(:user) { User.create(:name => "Bob") }

    before :each do
      user.destroy
    end

    it "should have deleted_at time" do
      user.deleted_at.is_a?(Time).should be_true
    end

    it "should not be findable by default" do
      expect { User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should be findable via unscoped" do
      expect { User.unscoped.find(user.id) }.to_not raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "User with another default_scope" do
    let(:connection) { ActiveRecord::Base.connection }
    let(:table_name) { connection.quote_table_name("users") }
    let(:column_name) { connection.quote_column_name("deleted_at") }
    let(:field) { "#{table_name}.#{column_name}" }

    before :each do
      class User < ActiveRecord::Base
        include HistoricalSociety
        default_scope order(:name)
      end
    end

    it "should combine default scopes" do
      User.scoped.to_sql.should include("ORDER BY name")
      User.scoped.to_sql.should include("#{field} IS NOT NULL")
    end
  end


end
