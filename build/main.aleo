program guess_my_number.aleo;

record SecretNumber:
    owner as address.private;
    number as u32.private;


mapping hall_of_fame:
	key left as address.public;
	value right as boolean.public;

function create_secret_number:
    input r0 as u32.private;
    cast self.caller r0 into r1 as SecretNumber.record;
    output r1 as SecretNumber.record;


function check_winner:
    input r0 as SecretNumber.record;
    input r1 as u32.private;
    input r2 as address.private;
    is.eq r1 r0.number into r3;
    ternary r3 true false into r4;
    ternary r3 r2 r2 into r5;

    finalize r4 r5;

finalize check_winner:
    input r0 as boolean.public;
    input r1 as address.public;
    set r0 into hall_of_fame[r1];
