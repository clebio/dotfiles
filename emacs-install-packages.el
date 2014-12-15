(require 'cl)
 
(defvar my-packages
  '(ack-and-a-half auctex clojure-mode coffee-mode deft expand-region
                   gist groovy-mode haml-mode haskell-mode inf-ruby
                   magit magithub markdown-mode paredit projectile python
                   sass-mode rainbow-mode scss-mode solarized-theme
                   volatile-highlights yaml-mode yari zenburn-theme)
  "A list of packages to ensure are installed at launch.")
 
(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))
 
(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))