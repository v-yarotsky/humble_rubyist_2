# Category: Tools

Making Iterm2 and IRSSI play well together
==========================================

I've stumbled upon yet another mac CLI issue: PageUp and PageDown (or, more precisely, Fn+Up, Fn+Down) just don't work the way they should in Iterm2.
This effectively prevents IRSSI usage through Iterm2.

<!-- more -->

To fix this issue, go to _Preferences->Profiles->Keys_, and add these:

  Key: Fn+Up (PageUp)
  Action: Send Escape Sequence Esc+ "[5~"

  Key: Fn+Down (PageDown)
  Action: Send Escape Sequence Esc+ "[6~"

The result will look like this:

  ``PageUp:       Send ^[[5~``
  ``PageDown:  Send ^[[6~``

That's it, now things should work fine.

