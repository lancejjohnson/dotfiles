;; Emacs UI preferences

(defun ljj/remove-gui-cruft ()
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0))

(defun ljj/set-initial-frame-size ()
  (set-frame-size (selected-frame) 165 47))

(defun ljj/set-default-font ()
  (set-default-font "Inconsolata-dz 16"))

(defun ljj/solarize-emacs ()
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/solarized")
  (set-frame-parameter nil 'background-mode 'dark)
  (load-theme 'solarized t))


;;;;;;;;;;

(ljj/set-initial-frame-size)
(ljj/remove-gui-cruft)
(ljj/set-default-font)
(ljj/solarize-emacs)
