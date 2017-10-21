(tool-bar-mode -1)
(menu-bar-mode -1) 
(toggle-scroll-bar -1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(package-initialize)
(elpy-enable)
(require 'evil)
(evil-mode 1)

(package-initialize)

(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(set-default-font "Monospace-16")

(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(when window-system (set-frame-size (selected-frame) 79 40))
;;(add-to-list 'default-frame-alist '(fullscreen . fullheight))
;;(add-to-list 'default-frame-alist '(width . 79))
;;(setq initial-frame-alist '((left . 400) (top . 0)))

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(add-hook 'after-init-hook #'neotree-toggle)
 (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

    ;; scroll one line at a time (less "jumpy" than defaults)
    
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
    
    (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
    
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
    
    (setq scroll-step 1) ;; keyboard scroll one line at a time


(setq
 ;; use gdb-many-windows by default
  gdb-many-windows t
 ;;gdb-many-windows nil

 ;; Non-nil means display source file containing the main routine at startup
  gdb-show-main t
)

;;-------------
;;Add color to the current GUD line (obrigado google)

(defvar gud-overlay
(let* ((ov (make-overlay (point-min) (point-min))))
(overlay-put ov 'face 'secondary-selection)
ov)
"Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
"Highlight current line."
(let* ((ov gud-overlay)
(bf (gud-find-file true-file)))
(save-excursion
  (set-buffer bf)
  (move-overlay ov (line-beginning-position) (line-end-position)
  (current-buffer)))))

(defun gud-kill-buffer ()
(if (eq major-mode 'gud-mode)
(delete-overlay gud-overlay)))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)
;;-------------------------------------------------------------

(setq inhibit-startup-screen t)

;; Highlight parentneses
(show-paren-mode 1)

(load-theme 'desert t t)
(enable-theme 'desert)

;;(set-face-attribute 'vertical-border
;;nil
;;:foreground "white")

;;(set-face-background 'vertical-border "green")
;;(set-face-foreground 'vertical-border (face-background 'vertical-border))

;;(setq python-shell-interpreter "ipython"
;;              python-shell-interpreter-args "-i")

;;(when (executable-find "ipython")
;;  (setq python-shell-interpreter "ipython"))
;;(setq python-shell-interpreter "ipython"
;;              python-shell-interpreter-args "-i")
;;(setq python-shell-interpreter "ipython"
;;              python-shell-interpreter-args "-i")
;;(setq python-shell-interpreter "ipython"
;;          python-shell-interpreter-args "--simple-prompt -i")
;;(setq py-split-windows-on-execute-p t)
;;(setq py-force-py-shell-name-p t)

(defun run-python-script() 
  (interactive)
  (when (<= (length (window-list)) 2)
    (split-window-below -10))
  (elpy-shell-send-region-or-buffer t))
(global-set-key [f5] 'run-python-script)
(local-set-key (kbd "<f5>") 'run-python-script)

(defun add-py-debug ()  
      "add debug code and move line down"  
    (interactive)  
;;    (move-beginning-of-line 1)  
    (insert "import pdb; pdb.set_trace(context=1)\n")
    (save-buffer)
    )  

(global-set-key [f9] 'add-py-debug)
(local-set-key (kbd "<f9>") 'add-py-debug)

(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-S-iso-lefttab] 'previous-buffer)

(setq make-backup-files nil)
(global-auto-revert-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(modify-syntax-entry ?_ "w")


;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;;(defun myf5 ()
;;  (interactive)
;;  (split-window-below 30)
;;    )

;;(global-set-key [f5] 'myf5)
;;(local-set-key (kbd "<f5>") 'myf5)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (pyenv-mode transpose-frame realgud-rdb2 neotree jedi-core evil elpy column-marker color-theme-solarized color-theme-modern auto-complete)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
