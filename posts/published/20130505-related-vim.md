# Category: Tools
# Tags: vim, tdd, rspec

Related.vim – a better TDD workflow for VIM
===========================================

How do you run your tests?

Ctrl+Z, then rspec spec/foo/bar_spec.rb, and back to vim with fg?
or :!rspec spec/foo/bar_spec.rb?

How do you toggle between a source and a test?

Does it have to be this way?
I bet it doesn't.

That's why I've created a vim plugin - [Related.vim](https://github.com/v-yarotsky/related.vim)

<!-- more -->

It has 2 simple commands:

```
:RelatedRunTest - runs test for current source (or test at hand)
:RelatedOpenFile - toggles between test and source
```

I've mapped these to `,` and `,,` appropriately, like this:

```
nmap , :RelatedRunTest
nmap ,, :RelatedOpenFile
```

But wait, there's more to it!

It also can send run-test commands to named pipe given to `:RelatedPipe` command.
It allows to run tests somewhere else, like in separate terminal window:

```sh
$ mkfifo my-tests
$ while true; do sh -c "$(cat my-tests)"; done
```

How neat is this, huh?

Oh, and it supports RSpec, MiniTest and Test::Unit, by the way.

