(defun ljj/mac? ()
  "Returns `t' if this is an Apple machine, nil otherwise."
  (eq system-type 'darwin))

(defun hrs/add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; See http://mattbriggs.net/blog/2012/03/18/awesome-emacs-plugins-ctags/
;; (defun build-ctags ()
;;   (interactive)
;;   (message "building project tags")
;;   (let ((root (projectile-project-root)))
;;     (shell-command (concat "ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f " root "TAGS " root)))
;;   (visit-project-tags)
;;   (message "tags built successfully"))

;; (defun visit-project-tags ()
;;   (interactive)
;;   (let ((tags-file (concat (projectile-project-root) "TAGS")))
;;     (visit-tags-table tags-file)
;;     (message (concat "Loaded " tags-file))))
