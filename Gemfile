# frozen_string_literal: true
source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby "2.4.0"

gem "dotenv"
gem "puma"
gem "sinatra"
gem "rest-client"
gem "nokogiri"
gem "alexa_rubykit"
gem "rack-cors", :require => "rack/cors"

group :development, :test do
  gem "byebug"
  gem "rake", "~> 10.4"
  gem "foreman"
end

group :test do
  gem "rspec"
  gem "rack-test"
  gem "webmock"
end
