#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

# The account of the first player.
# Private Key  APrivateKey1zkpJPGtssru2SzRpzgyuHiGHvCwL8SwKQDMvpWxXoKTt6Jd
# View Key  AViewKey1hywEUN5AMiyNd755nJcNSaKumQ1YXh7SBgbGMvedYmZU
# Address  aleo1zv5rpcgxywhkuu8h92xcxz3wd5nrhle9386x5rjsagt59v208y9sthafcc

# The account of the second player.
# Private Key  APrivateKey1zkp925BKkg6UE1iCbGRgPqSEPQKxLomGc53z6Ar3BYRiUii
# View Key  AViewKey1d1uQYKD5zgdEZRK7xzNHQWe6xyiNC9thvLyZzDoEEMh9
# Address  aleo170hvh2y7g3m2d0urvgd0vla4p2rw080rqew6p32f94j736pktcqsyjnh0n

echo "
###############################################################################
########                                                               ########
########            STEP 1: Player 1 creates a secret number           ########
########                                                               ########
###############################################################################
"
# Swap in the private key of the first player to .env.
echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkpJPGtssru2SzRpzgyuHiGHvCwL8SwKQDMvpWxXoKTt6Jd
" > .env

leo run create_secret_number 7u32 || exit

echo "
###############################################################################
########                                                               ########
########          STEP 2: Player 2 makes a guess off-chain             ########
########                                                               ########
###############################################################################
"

echo "
###############################################################################
########                                                               ########
########    STEP 3: Player 1 checks guess and updates hall_of_fame     ########
########                                                               ########
###############################################################################
"

leo run check_winner "{
  owner: aleo1zv5rpcgxywhkuu8h92xcxz3wd5nrhle9386x5rjsagt59v208y9sthafcc.private,
  number: 7u32.private,
  _nonce: 5661231340993992740976978172074107413872443099514604768341256937104359716756group.public
}" 7u32 aleo170hvh2y7g3m2d0urvgd0vla4p2rw080rqew6p32f94j736pktcqsyjnh0n
