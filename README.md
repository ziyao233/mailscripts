# mailscript

This is a collection of scripts (mostly written in ``Lua``)
which is used to send, receive, edit and reply mails without
a mail agent.

## Dependency

These scripts depends on `curl`, `Lua 5.4` (with io.popen support)

## Configuration

A configuration file, `~/.msrc.lua` is loaded.

An example is contained (see `msrc.lua`)

## Commands

- `ms-send` : send a file by SMTP
- `ms-stat` : get the status of a POP3 mailbox
- `ms-recv` : receive mails from a POP3 mailbox
- `ms-fetch-thread`: Fetch a thread from the public mail box (lore.kenrel.org)
- `ms-mbox-split`: Split a mbox file

## Workflow
