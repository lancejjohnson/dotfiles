;; (chruby "ruby-2.2.4")
;; (require 'rcodetools)

(defun hrs/insert-binding-pry ()
  (interactive)
  (move-end-of-line 1)
  (newline)
  (indent-relative)
  (insert "require \"pry\"; binding.pry"))

(add-hook 'ruby-mode-hook
	  (lambda ()
	    (setq ruby-insert-encoding-magic-comment nil)
            (rspec-mode)
            (projectile-rails-mode)
            (flycheck-mode)
            (local-set-key "\r" 'newline-and-indent)
	    (linum-mode)
            ;; (setq rspec-command-options "--color --order random")
            (define-key ruby-mode-map (kbd "C-c b") 'hrs/insert-binding-pry)))

(hrs/add-auto-mode 'ruby-mode
                   "\\Gemfile$" "\\.rake$" "\\.gemspec$" "\\Gemfile$"
                   "\\Guardfile$" "\\Rakefile$" "\\Vagrantfile$"
                   "\\Vagrantfile.local$")
