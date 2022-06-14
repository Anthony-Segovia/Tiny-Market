
;; sip009-nft
;; implement the contract that the trait is in
(impl-trait .sip009-nft-trait.sip009-nft-trait)
 
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-token-id-failure (err u102))
(define-non-fungible-token certipros uint)
(define-data-var token-id-nonce uint u0)

;; return a response with the id of the last minted token
(define-read-only (get-last-token-id)
  		(ok (var-get token-id-nonce))
)

(define-read-only (get-owner (token-id uint))
		(ok (nft-get-owner? certipros token-id))
)

(define-read-only (get-token-uri (token-id uint))
		(ok none)
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
		(begin
			(asserts! (is-eq tx-sender sender) err-not-token-owner)
			(nft-transfer? certipros token-id sender recipient)
		)
)

;; mint a token
(define-public (mint (recipient principal))
		(let ((token-id (+ (var-get token-id-nonce) u1)))
			(asserts! (is-eq tx-sender contract-owner) err-owner-only)
			(try! (nft-mint? certipros token-id recipient))
			(asserts! (var-set token-id-nonce token-id) err-token-id-failure)
			(ok token-id)
		)
)