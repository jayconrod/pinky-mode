# Introduction

"Emacs Pinky" is a condition where you feel pain in one or both of
your pinky fingers from using Emacs. This is because Emacs requires
you to hold `[Ctrl]` to do anything other than inserting text. On
most keyboards, `[Ctrl]` is pressed with the pinky, so this causes a
lot of stress.

What can you do about this though? Switch to Vim? You'll have to
learn a new set of key bindings and throw away all your
customizations! It will be awful!

pinky-mode to the rescue! pinky-mode is a minor mode which lets you
use most common navigation commands without touching `[Ctrl]`. It is
inspired by command mode in Vim. Once activated, just use the letter
keys to navigate your buffer. For example, press n instead of `C-n` to
move to the next line. This lets you keep using your muscle memory!
See the full list of key bindings below. Press i to leave pinky-mode
and go back to inserting text.

When pinky-mode is active, the cursor color will change, and
"Pinky" will be shown in the mode line. You can customize the cursor
color with `M-x customize-group RET pinky RET`.

pinky-mode works with window-number to switch between windows in
the same frame. Just tap a number key to go to any window.

## Installation:

Once the pinky-mode package is installed, add this to your .emacs:

```elisp
(require 'pinky-mode)
```

You will need to bind pinky-mode-activate to something you can
press easily. I use the key-chord package to bind this to `jk`
(press `j` and `k` at the same time). This is entirely up to you
though.

```elisp
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jk" 'pinky-mode-activate)
```

To force yourself to learn pinky-mode, consider disabling the
normal key bindings for navigation.

```elisp
(pinky-unbind-normal-keys)
```

## List of key bindings

| Key | Function |
| --- |:--------:|
| ` ` | set-mark-command |
| `,` | beginning-of-buffer |
| `.` | end-of-buffer |
| `a` | move-beginning-of-line |
| `b` | backward-char |
| `c` | switch-to-buffer |
| `d` | delete-char |
| `e` | move-end-of-line |
| `f` | forward-char |
| `g` | goto-line |
| `i` | pinky-mode-deactivate |
| `k` | kill-line |
| `m` | scroll-down-command |
| `n` | next-line |
| `o` | open-line |
| `p` | previous-line |
| `r` | isearch-backward |
| `s` | isearch-forward |
| `u` | undo |
| `v` | scroll-up-command |
| `w` | kill-ring-save |
| `x` | exchange-point-and-mark |
| `y` | yank |
| `0`-`9` | window-number-select |
