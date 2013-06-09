# Dotman

This is a work in progress.

This gem will allow you to switch between different dotfiles on the same user account.

## Installation

Add this line to your application's Gemfile:

    gem 'dotman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dotman
## Usage

To retrieve your dotfiles and store them:

    dot clone <git repository> <alias> : clone the dotfiles repo

To use cloned dotfiles:

    dot use <alias> 

To list currently downloaded dotfiles:

    dot alias list
or
    dot list 

To revert dotfiles back to original:

    dot use default 

To create a new dotfiles directory with all current dotfiles located in the HOME directory:

    dot collect

To change the alias name:

    dot alias change <old alias> <new alias> 


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
