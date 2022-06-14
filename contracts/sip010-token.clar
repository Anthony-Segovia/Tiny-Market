(impl-trait .sip010-ft-trait.sip010-ft-trait)

;; Define certicoin with a maximum of 1,000,000,000 tokens
(define-fungible-token certi-coin u1000000000)

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))



(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
    (begin
        (asserts! (is-eq tx-sender sender) err-owner-only)
        (ft-transfer? certi-coin amount sender recipient)
    )
)


(define-read-only (get-name)
    (ok "Certi Coin")
)

(define-read-only (get-symbol)
    (ok "CC")
)

(define-read-only (get-decimals)
    (ok u6)
)

(define-read-only (get-balance (who principal))
    (ok (ft-get-balance certi-coin who))
)

(define-read-only (get-total-supply)
	(ok (ft-get-supply certi-coin))
)

(define-read-only (get-token-uri)
    (ok none)
)

(define-public (mint (amount uint) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (ft-mint? certi-coin amount recipient)
    )
)
