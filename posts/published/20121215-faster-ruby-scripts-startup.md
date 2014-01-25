# Category: Programming
# Tags: ruby

How to make ruby scripts start faster
=====================================

If you like command-line tools and Ruby – sooner or later you'll encounter a problem: your scripts take more than half a second just to start!
The problem is rubygems, of course. The more gems you have installed in your environment, the worse things are getting.

So, here is a quick'n'dirty solution to this problem for RVM users.

<!-- more -->

1. Install the fastest ruby (in other words – not MRI Ruby 1.9.2)
2. Create a new gemset just for tools you want to run:

    rvm --create use ruby-1.9.3@tools

3. Install your tools, i.e.

    gem install taketo

4. Create a wrapper for each tool:

    rvm wrapper ruby-1.9.3@tools --no-prefix taketo

Benefits:

- Scripts start real quick
- Scripts are available for all rubies

Profit!

