# Category: Programming
# Tags: ruby

Yet another Ruby special case: Struct
=====================================

Today me and my teammates discovered one interesting fact about ruby structs.
It turned out that in Ruby 1.9 they have some special behavior when they are being marshalled.

<!-- more -->

Consider the example:

```ruby
class WorkingExample
  def initialize
    @foo = 1
    @bar = 2
  end

  def marshal_dump
    @foo
  end

  def marshal_load(foo)
    @foo = foo
  end
end

class FaultyExample < Struct.new(:foo, :bar)
  def initialize
    super(1, 2)
    @qux = 3
  end

  def marshal_dump
    foo
  end

  def marshal_load(foo)
    @foo = foo
  end

  def inspect
    "@foo=#@foo, @bar=#@bar, @qux=#@qux"
  end
end

a = WorkingExample.new
puts "WorkingExample before dump and load: #{a.inspect}"
puts "WorkingExample dump #{Marshal.dump(a)}"
puts "WorkingExample after dump and load: #{Marshal.load(Marshal.dump(a)).inspect}"

puts

b = FaultyExample.new
puts "FaultyExample before dump and load: #{b.inspect}"
puts "FaultyExample dump #{Marshal.dump(b)}"
puts "FaultyExample after dump and load: #{Marshal.load(Marshal.dump(b)).inspect}"
```

Here is the output from Ruby 1.8:

    WorkingExample before dump and load: #<WorkingExample:0x1076c37e0 @foo=1, @bar=2>
    WorkingExample dumpU:WorkingExamplei
    WorkingExample after dump and load: #<WorkingExample:0x1076c33d0 @foo=1>

    FaultyExample before dump and load: @foo=,@bar=,@qux=3
    FaultyExample dumpIU:FaultyExamplei
    FaultyExample after dump and load: @foo=1,@bar=,@qux=

And that's the output of Ruby 1.9:

    WorkingExample before dump and load: #<WorkingExample:0x007fa18209ca88 @bar=2, @foo=1>
    WorkingExample dumpU:WorkingExamplei
    WorkingExample after dump and load: #<WorkingExample:0x007fa18209c830 @foo=1>

    FaultyExample before dump and load: @foo=,@bar=,@qux=3
    FaultyExample dumpIU:FaultyExamplei:    @quxi
    FaultyExample after dump and load: @foo=1,@bar=,@qux=3

Note that in ruby 1.9 output we have @qux = 3 instance variable on FaultyExample instance restored with Marshal.load. That means that ruby does not care much about your custom marshal_dump method in struct (or it's descendants) and dumps instance variables!
This wasn't the case in ruby 1.8.

It bite us in rspec example, where it tried to dump a mock object, with not-so-obvious failure: "singleton can't be dumped".
So, beware of this :)

