;;------------------------------------------------------------
;; settings for org mode
;;------------------------------------------------------------

(require 'org)

;; (define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; list files to search for agenda
(setq org-agenda-files (list "~/Dropbox/notes"))

;; multi-state workflow for TODO
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "SKIP")))


;; sort by time and then by TODO
(defun org-sort-todo-deadine ()
  "Group Org-mode entries by TODO keyword and sort alphabetically.

This function achieves this by first sorting alphabetically and
then sorting by TODO keyword. This works because the TODO-sort in
`org-sort-entries' preserves the initial alphabetical sort."
  (interactive)
  ;; First sort by deadline & time
  (org-sort-entries t ?d)
  (org-sort-entries t ?t)
  ;; Then sort by TODO keyword
  (org-sort-entries t ?o)

  ;; show outline mode
  (org-global-cycle)
  (org-global-cycle)
  )

;; --------------------------------------------------------------------
;; set up to convert org-mode into word processor
;; http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
;; --------------------------------------------------------------------
(setq org-hide-emphasis-markers t)
(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                             ((x-list-fonts "Verdana")         '(:font "Verdana"))
                             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                             (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces 'user
                          `(org-level-8 ((t (,@headline ,@variable-tuple))))
                          `(org-level-7 ((t (,@headline ,@variable-tuple))))
                          `(org-level-6 ((t (,@headline ,@variable-tuple))))
                          `(org-level-5 ((t (,@headline ,@variable-tuple))))
                          `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1 :foreground "Blue"))))
                          `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25 :foreground "CornflowerBlue"))))
                          `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5 :foreground "SeaGreen"))))
                          `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75 :foreground "DarkGreen"))))
                          `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))

(provide 'org-settings)


