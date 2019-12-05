#!/usr/bin/env perl
use utf8;

use strict;
use warnings;

use Test::More;
use Test::Needs 'LWP::UserAgent';
use Test::RequiresInternet;

use Bio::Perl;

# This should probably be replaced by a sequence on file so we are not
# dependent on get_sequence behaving properly.
my $seq = get_sequence('genpept', 'AAC06201');

# This can take a very long time...
my $blast_report = blast_sequence($seq, 0);
ok $blast_report;
isa_ok $blast_report, 'Bio::Search::Result::ResultI';

done_testing();
