(let ((target-dir (expand-file-name "~/"))
      (dest-dir (expand-file-name "~/.Trash/")))
  (add-to-list 'auto-save-file-name-transforms
               `(,(concat target-dir "\\([^/]*/\\)*\\([^/]*\\)$")
                 ,(concat dest-dir "\\2")
                 t))
  (add-to-list 'backup-directory-alist (cons target-dir dest-dir))
  (setq auto-save-list-file-prefix (expand-file-name ".saves-" dest-dir)))
