// The 'guess_my_number' program.
program guess_my_number.aleo {
    //player -> is_winner (hall of fame)
    mapping hall_of_fame: address => bool;

    record SecretNumber {
        owner: address,
        number: u32,
    }

    transition create_secret_number(number: u32) -> SecretNumber {
        return SecretNumber {
            owner: self.caller,
            number: number,
        };
    }

    transition check_winner(secret: SecretNumber, guess: u32, guesser: address) {
        if (guess == secret.number) {
            return then finalize(true, guesser);
        }
        return then finalize(false, guesser);
    }

    finalize check_winner(is_winner: bool, guesser: address) {
        Mapping::set(hall_of_fame, guesser, is_winner);
    }
}
