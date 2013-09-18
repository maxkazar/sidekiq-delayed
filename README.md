# Sidekiq::Delayed

Sidekiq delayed extension for models instances (ActiveRecord, MongoID)

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-delayed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-delayed

## Usage

    post = Post.find(1)

To destroy in background

    post.delay.destroy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
