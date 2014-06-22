;;; pinky-mode.el --- Navigate without holding meta keys.

;; Copyright (C) 2013-2014, Jay Conrod, all rights reserved.

;; Author: Jay Conrod <jayconrod@gmail.com>
;; Description: Navigate without holding meta keys.
;; Keywords: pinky key bindings navigation
;; Version: 1
;; Package-Requires: ((window-number "1.0"))

;; This file is NOT part of GNU Emacs

;; License
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:

;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.

;; 2. Redistributions in binary form must reproduce the above
;;    copyright notice, this list of conditions and the following
;;    disclaimer in the documentation and/or other materials provided
;;    with the distribution.

;; 3. Neither the name of the copyright holder nor the names of its
;;    contributors may be used to endorse or promote products derived
;;    from this software without specific prior written permission.

;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
;; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.


;;; Commentary:
;;
;; "Emacs Pinky" is a condition where you feel pain in one or both of
;; your pinky fingers from using Emacs. This is because Emacs requires
;; you to hold [Ctrl] to do anything other than inserting text. On
;; most keyboards, [Ctrl] is pressed with the pinky, so this causes a
;; lot of stress.
;;
;; What can you do about this though? Switch to Vim? You'll have to
;; learn a new set of key bindings and throw away all your
;; customizations! It will be awful!
;;
;; pinky-mode to the rescue! pinky-mode is a minor mode which lets you
;; use most common navigation commands without touching [Ctrl]. It is
;; inspired by command mode in Vim. Once activated, just use the letter
;; keys to navigate your buffer. For example, press n instead of C-n to
;; move to the next line. This lets you keep using your muscle memory!
;; See the full list of key bindings below. Press i to leave Pinky
;; mode and go back to inserting text.
;;
;; When pinky-mode is active, the cursor color will change, and
;; "Pinky" will be shown in the mode line. You can customize the cursor
;; color with M-x customize-group RET pinky RET.
;;
;; pinky-mode works with window-number to switch between windows in
;; the same frame. Just tap a number key to go to any window.

;;; Installation:
;;
;; Once the pinky-mode package is installed, add this to your .emacs:
;;
;;   (require 'pinky-mode)
;;
;; You will need to bind pinky-mode-activate to something you can
;; press easily. I use the key-chord package to bind this to "jk"
;; (press j and k at the same time). This is entirely up to you
;; though.
;;
;;   (require 'key-chord)
;;   (key-chord-mode 1)
;;   (key-chord-define-global "jk" 'pinky-mode-activate)
;;
;; To force yourself to learn pinky-mode, consider disabling the
;; normal key bindings for navigation.
;;
;;   (pinky-unbind-normal-keys)

;;; Code:

(require 'window-number)

(defgroup pinky nil "Pinky mode group"
  :group 'editing)

(defcustom pinky-active-color "red"
  "The color of the point when pinky mode is active."
  :type 'color
  :group 'pinky)

;; TODO: it would be good to set the default to the normal cursor face
;; background color. I can't figure out the symbol of this though.
(defcustom pinky-inactive-color "black"
  "The color of the point when pinky mode is inactive."
  :type 'color
  :group 'pinky)

(defvar pinky-mode-in-minibuffer nil)

(defun pinky-mode-activate ()
  (interactive)
  (pinky-mode t)
  (set-cursor-color pinky-active-color))

(defun pinky-mode-deactivate ()
  (interactive)
  (pinky-mode -1)
  (set-cursor-color pinky-inactive-color))

(defvar pinky-mode-map
  (let ((map (make-keymap)))
    (define-key map "i" 'pinky-mode-deactivate)
    (define-key map "n" 'next-line)
    (define-key map "p" 'previous-line)
    (define-key map "f" 'forward-char)
    (define-key map "b" 'backward-char)
    (define-key map "a" 'move-beginning-of-line)
    (define-key map "e" 'move-end-of-line)
    (define-key map "," 'beginning-of-buffer)
    (define-key map "." 'end-of-buffer)
    (define-key map "v" 'scroll-up-command)
    (define-key map "m" 'scroll-down-command)
    (define-key map "g" 'goto-line)
    (define-key map " " 'set-mark-command)
    (define-key map "k" 'kill-line)
    (define-key map "w" 'kill-ring-save)
    (define-key map "y" 'yank)
    (define-key map "o" 'open-line)
    (define-key map "u" 'undo)
    (define-key map "s" 'isearch-forward)
    (define-key map "r" 'isearch-backward)
    (define-key map "d" 'delete-char)
    (define-key map "x" 'exchange-point-and-mark)
    (define-key map "c" 'switch-to-buffer)
    (define-key map "1" 'pinky-window-1)
    (define-key map "2" 'pinky-window-2)
    (define-key map "3" 'pinky-window-3)
    (define-key map "4" 'pinky-window-4)
    (define-key map "5" 'pinky-window-5)
    (define-key map "6" 'pinky-window-6)
    (define-key map "7" 'pinky-window-7)
    (define-key map "8" 'pinky-window-8)
    (define-key map "9" 'pinky-window-9)
    map))


;; TODO: This doesn't seem like a great way to accomplish this. Too bad we
;; can't bind a key to a lambda above.
(defun pinky-window-1 ()
  (interactive)
  (window-number-select 1))

(defun pinky-window-2 ()
  (interactive)
  (window-number-select 2))

(defun pinky-window-3 ()
  (interactive)
  (window-number-select 3))

(defun pinky-window-4 ()
  (interactive)
  (window-number-select 4))

(defun pinky-window-5 ()
  (interactive)
  (window-number-select 5))

(defun pinky-window-6 ()
  (interactive)
  (window-number-select 6))

(defun pinky-window-7 ()
  (interactive)
  (window-number-select 7))

(defun pinky-window-8 ()
  (interactive)
  (window-number-select 8))

(defun pinky-window-9 ()
  (interactive)
  (window-number-select 9))


(defun pinky-unbind-normal-keys ()
  "Unbinds the normal navigation keys to force you to save your pinkies!"
  (interactive)
  (global-unset-key (kbd "C-n"))
  (global-unset-key (kbd "C-p"))
  (global-unset-key (kbd "C-f"))
  (global-unset-key (kbd "C-b"))
  (global-unset-key (kbd "C-a"))
  (global-unset-key (kbd "C-e"))
  (global-unset-key (kbd "C-v"))
  (global-unset-key (kbd "M-v")))


(define-minor-mode pinky-mode
  "Navigate without holding meta keys"
  :lighter " Pinky" :global t :keymap pinky-mode-map)


(add-hook 'minibuffer-setup-hook (lambda nil
  (setq pinky-mode-in-minibuffer pinky-mode)
  (if pinky-mode (pinky-mode-deactivate))))

(add-hook 'minibuffer-exit-hook (lambda nil
  (if pinky-mode-in-minibuffer (pinky-mode-activate))))


(provide 'pinky-mode)

;;; pinky-mode.el ends here
