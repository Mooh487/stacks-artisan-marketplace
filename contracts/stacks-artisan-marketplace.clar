;; stacks-artisan-marketplace

;; Define constants
(define-data-var platform-fee uint u5) ;; 5% platform fee, can be changed by owner

;; Error codes
(define-constant contract-owner tx-sender)
(define-constant err-not-owner (err u100))
(define-constant err-already-registered (err u101))
(define-constant err-not-registered (err u102))
(define-constant err-item-not-found (err u103))
(define-constant err-item-already-sold (err u104))
(define-constant err-insufficient-funds (err u105))
(define-constant err-not-found (err u404))
(define-constant err-already-sold (err u500))
(define-constant err-invalid-input (err u600))
(define-constant err-fee-too-high (err u601))
(define-constant err-zero-price (err u602))

;; Storage
(define-map artisans 
  { wallet: principal }
  { name: (string-utf8 100), description: (string-utf8 500), verified: bool }
)

(define-map craft-items 
  { id: uint }
  { 
    artisan: principal, 
    name: (string-utf8 100), 
    description: (string-utf8 500), 
    price: uint, 
    image-url: (string-utf8 500),
    sold: bool 
  }
)

(define-data-var next-item-id uint u0)

;; Events
(define-public (print-artisan-registered (artisan principal))
  (ok (print { type: "artisan-registered", artisan: artisan }))
)

(define-public (print-item-listed (item-id uint))
  (ok (print { type: "item-listed", item-id: item-id }))
)

;;Register Artisan
(define-public (register-artisan (name (string-utf8 100)) (description (string-utf8 500)))
  (let ((artisan-data (get-artisan tx-sender)))
    (asserts! (is-none artisan-data) err-already-registered)
    (asserts! (> (len name) u0) err-invalid-input)
    (asserts! (> (len description) u0) err-invalid-input)
    (map-set artisans { wallet: tx-sender } 
      { name: name, description: description, verified: false })
    (ok true)
  )
)

;; Update Artisan Information
(define-public (update-artisan-info (name (string-utf8 100)) (description (string-utf8 500)))
  (let ((artisan-data (unwrap! (get-artisan tx-sender) err-not-registered)))
    (asserts! (> (len name) u0) err-invalid-input)
    (asserts! (> (len description) u0) err-invalid-input)
    (map-set artisans { wallet: tx-sender } 
      (merge artisan-data { name: name, description: description }))
    (ok true)
  )
)

;; Verify Artisan (only contract owner can do this)
(define-public (verify-artisan (artisan principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-not-owner)
    (let ((artisan-data (unwrap! (get-artisan artisan) err-not-registered)))
      (map-set artisans { wallet: artisan } 
        (merge artisan-data { verified: true }))
      (ok true)
    )
  )
)