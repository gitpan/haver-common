# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Haver.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN {
	use_ok('Haver');
	use_ok('Haver::Protocol');
};

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
my $f = new Haver::Protocol::Filter;
my $s = "MSG\tdylan\tbunnies\xD\xA";

is($f->put($f->get([$s]))->[0], $s, 'filter input is filter output');
