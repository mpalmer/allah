"Allah" is a god-compatible command-line tool to manage daemontools
services.


# Why "god-compatible"?

Because:

* We have a bunch of customers who manage their services using god;
* We dislike god and prefer daemontools; and
* It's easier to provide a command-line wrapper that acts like god's command
  line interface than it is to rewrite all the deployment and automation
  that uses god.


# What's wrong with svc?

Not a whole lot, although it's not the most discoverable or newbie-friendly
interface.  Also, see "Why 'god-compatible'?", above.


# How do I use it?

Start with:

    allah help

And go from there.


# How do I group services together?

Simply create a file in your service directory (`/etc/service/whatever`)
named `group`, containing one or more whitespace-separated group names. 
service is a part of (eg `echo thins >/etc/service/thin0/group` or `echo
customer resque customer_workers >/etc/service/customer_resque_12/group`). 
All services with the same group name can be controlled together by
providing the group name to the `start`/`stop`/`restart`/etc commands.


# Compatibility

While developing `allah`, I discovered a number of "nits" in the way that
god worked, and I was unwilling to unconditionally duplicate them.  As a
result, `allah` has a "god mode", which is enabled when called as `god`
(symlinks ftw), and is intended to be nit-for-nit compatible with `god` --
every command input, command output, and action should be as faithfully
recreated as we can make it, except we're manipulating daemontools services
instead.

This "god mode" is known to be incomplete, and I improve as people report
that they've found a difference that makes a real impact on their
operations.  If you find an instance where invoking allah in "god mode"
produces different results than god itself, and it's causing you problems,
please let me know by providing:

* Your version of god and allah (`god -V` and `allah -V`)
* The command run
* The output / action taken by god
* The output / action taken by allah
* If necessary, the `run` script from your daemontools service

I'll then do what I can to fix it up.


## Differences between god and allah

In "allah mode", we do things a bit differently than god.  While we try to
do the same things as god where it makes sense, there's plenty of things we
either can't or don't have to do.  The following list is a condensed
description of the things that allah is known to do differently to god:

* Stopping a service in god involves it sending a `TERM`, waiting a little
  while, then sending a `KILL`.  This is somewhat over-violent, as long as
  your services are well-behaved and don't eat the `TERM`.  Instead, `allah`
  just sends the `TERM` and assumes the process is well-behaved.
