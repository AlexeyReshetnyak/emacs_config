(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;;(package-refresh-contents)

(tool-bar-mode -1)
(menu-bar-mode -1) 
(toggle-scroll-bar -1)
(setq inhibit-startup-screen t)

(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))
(modify-syntax-entry ?_ "w")

(set-frame-font "Monospace-18")

(setq scroll-step 1) ;; keyboard scroll one line at a time

(show-paren-mode 1)

(setq make-backup-files nil)
(global-auto-revert-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)

(setq epa-file-select-keys nil)

(custom-set-variables
  '(custom-safe-themes
    '("aff12479ae941ea8e790abb1359c9bb21ab10acd15486e07e64e0e10d7fdab38" default)))

(load-theme 'solarized-dark)
