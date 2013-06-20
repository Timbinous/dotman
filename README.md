# Dotman [![Build Status](https://secure.travis-ci.org/Timbinous/dotman.png)](http://travis-ci.org/Timbinous/dotman?branch=master)
This gem allows you to switch between different dotfiles on the same user account.

## Requirements

ruby 1.8, 1.9, 2.0

## Installation

Download this repository:

    git clone git@github.com:Timbinous/dotfiles.git

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dotman

## Usage

To retrieve your dotfiles and store them:

    dot clone <git repository> <alias>

To use cloned dotfiles:

    dot use <alias> 

To list currently downloaded dotfiles:

    dot alias list

or simply just

    dot list 

To change the alias name:

    dot alias rename <old alias name> <new alias name> 

To revert dotfiles back to original state:

    dot use default 

To delete dotfiles collection:

    dot delete <alias> 

To create a new dotfiles directory with all current dotfiles located in the HOME directory:

    dot collect

### After Clone Hook

If you would like to execute a script after cloning down your dotfiles;
Add the script as an executable file named `.dotman.after_clone` in the root of your dotfiles

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
