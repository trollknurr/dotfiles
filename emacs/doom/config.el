;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!



;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Restore 's' as substitute (delete char + insert), like vanilla Vim.
;; Doom's evil-snipe module hijacks 's' for 2-char jump; disable it.
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

;; Enable word wrap
(+global-word-wrap-mode +1)

;; Don not copy replaced text on paste
(setq evil-kill-on-visual-paste nil)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((python-base-mode :language-id "python") . ("ty" "server"))))

(add-hook 'python-base-mode-hook 'eglot-ensure)

(setq python-shell-interpreter "uv"
      python-shell-interpreter-args "run python -i")

(after! treemacs
  (treemacs-project-follow-mode 1))

;; Diagrams in markdowns

(use-package! kitty-graphics
  :demand t
  :config
  ;; Картинки в markdown в натуральном размере, без вписывания в окно.
  ;; При scale nil всё равно режется по max-width/max-height (120x40),
  ;; поэтому лимиты задраны, чтобы картинка никогда не ужималась.
  (setq kitty-graphics-markdown-image-scale nil
        kitty-graphics-max-width 10000    ; колонки
        kitty-graphics-max-height 10000)  ; строки
  (kitty-graphics-setup))

(after! plantuml-mode
    (setq plantuml-default-exec-mode 'executable
            plantuml-output-type "png"))


;;; ztoken helpers

(defvar user/ztoken-cache-value nil
  "Cached value returned by ztoken command.")

(defun user/decode-jwt-payload (token)
  "Decode the payload part of a JWT TOKEN."
  (let* ((payload (nth 1 (split-string token "\\.")))
         (padding (make-string (% (- 4 (% (length payload) 4)) 4) ?=)))
    (json-parse-string
     (base64-decode-string (concat payload padding))
     :object-type 'plist)))

(defun user/token-expired-p (token)
  "Check if TOKEN is expired. Returns t if expired or invalid."
  (if (not token)
      t
    (let* ((decoded (user/decode-jwt-payload token))
           (exp (plist-get decoded :exp)))
      (or (not exp)
          (<= exp (time-to-seconds))))))

(defun user/get-ztoken ()
  "Get a valid ztoken, refreshing if necessary."
  (when (user/token-expired-p user/ztoken-cache-value)
    (setq user/ztoken-cache-value
          (string-trim (shell-command-to-string "ztoken"))))
  user/ztoken-cache-value)

(defun user/fetch-zllm-models ()
  "Fetch available models from ZLLM API and return list of model IDs."
  (let* ((url "https://zllm.data.zalan.do/models")
         (token (user/get-ztoken))
         (url-request-method "GET")
         (url-request-extra-headers
          `(("Authorization" . ,(format "Bearer %s" token)))))
    (with-current-buffer (url-retrieve-synchronously url :timeout 1)
      (goto-char url-http-end-of-headers)
      (let ((json-object-type 'alist)
            (json-array-type 'list)
            (response (json-read)))
        (mapcar (lambda (model)
                  (list
                   (intern (alist-get 'id model))
                   :capabilities '(media tool-use cache)
                   :mime-types '("image/png"
                                 "image/jpeg"
                                 "image/webp"
                                 "image/heic"
                                 "image/heif"
                                 "image/svg+xml"
                                 "application/pdf"
                                 "text/plain"
                                 "text/csv"
                                 "text/html")))
                (alist-get 'data response))))))

;;; gptel

(use-package! gptel
  :demand t
  :config
  (require 'gptel-integrations)
  (setq gptel-model 'bedrock/anthropic.claude-sonnet-5-5
        gptel-track-media t
        gptel-backend (gptel-make-openai "zllm"
                        :protocol "https"
                        :key #'user/get-ztoken
                        :host "zllm.data.zalan.do"
                        :stream t
                        :models (user/fetch-zllm-models)
                        :endpoint "/v1/chat/completions")))

;;; MCP
;; Requires: (package! mcp :recipe (:host github :repo "lizqian/mcp.el" :files ("*.el" "mcp-hub.el"))) in packages.el

(after! mcp
  (setq mcp-hub-servers
        '(("fetch" . (:command "uvx" :args ("mcp-server-fetch")))))
  (require 'mcp-hub)
  (mcp-hub-start-all-server))

;;; gptel-magit

(use-package! gptel-magit
  :after magit
  :hook (magit-mode-hook . gptel-magit-install))
