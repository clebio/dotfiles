; http://stackoverflow.com/a/10102154

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
	 nil
       (package-install package)
	 ))
   packages))

;; activate installed packages
(package-initialize)

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed
    'gist
    'coffee-mode
    'color-theme
    'elpy
    'yasnippet
    'pyvenv
    'nose
    'iedit
    'idomenu
    'highlight-indentation
    'fuzzy
    'find-file-in-project
    'auto-complete
    'popup
    'find-file-in-project
    'flycheck
    'let-alist
    'pkg-info
    'epl
    'dash
    'fuzzy
    'go-autocomplete
    'auto-complete
    'popup
    'go-mode
    'golint
    'highlight-indentation
    'idomenu
    'iedit
    'jedi
    'python-environment
    'deferred
    'auto-complete
    'popup
    'epc
    'ctable
    'concurrent
    'deferred
    'let-alist
    'markdown-mode
    'marmalade
    'furl
    'nose
    'paredit
    'pkg-info
    'epl
    'popup
    'python-environment
    'deferred
    'pyvenv
    'rainbow-delimiters
    'solarized-theme
    'dash
    'virtualenv
    'virtualenvwrapper
    's
    'dash
    'yasnippet
)
