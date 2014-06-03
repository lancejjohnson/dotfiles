;; Most of my Emacs config is Shamelessly stolen from
;; https://github.com/hrs/dotfiles


;; See https://github.com/hrs/sensible-defaults.el
(load-file "~/.emacs.d/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)

(defun ljj/configure-cask ()
  (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
  (cask-initialize)
  (require 'pallet)
  (pallet-mode t))

(defun ljj/include-custom-paths ()
  (add-to-list 'load-path "~/.emacs.d/lisp/")
  (add-to-list 'load-path "~/.emacs.d/modes/"))

(defun hrs/configure-auto-complete ()
  (require 'auto-complete-config)
  (ac-config-default))

(defun ljj/configure-all-custom-modes ()
  (mapcar (lambda (mode-file-name) (load mode-file-name))
          (directory-files "~/.emacs.d/modes/" nil ".el")))

(defun ljj/configure-ido ()
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)
  (ido-ubiquitous)
  (flx-ido-mode 1) ; better/faster matching
  (setq ido-create-new-buffer 'always)
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

(defun ljj/default-to-utf ()
  ;; Default to UTF-8 (see https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  ;; backwards compatibility as default-buffer-file-coding-system
  ;; is deprecated in 23.2.
  (if (boundp 'buffer-file-coding-system)
      (setq-default buffer-file-coding-system 'utf-8)
    (setq default-buffer-file-coding-system 'utf-8))

  ;; Treat clipboard input as UTF-8 string first; compound text next, etc.
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;;;;;;;;;;

(ljj/include-custom-paths)
(ljj/configure-cask)
(ljj/configure-ido)
(ljj/default-to-utf)

(load "util.el")
(load "ui-prefs.el")

(hrs/configure-auto-complete)
(ljj/configure-all-custom-modes)
(put 'downcase-region 'disabled nil)
