#!/usr/bin/env perl
use utf8;

use strict;
use warnings;

use Test::More;
use Test::Needs 'LWP::UserAgent';
use Test::RequiresInternet;

use Bio::Perl;

my %db2id = (
    'swissprot' => 'ROA1_HUMAN',
    'embl' => 'J00522',
    'genbank' => 'AI129902',
    'refseq' => 'NM_006732',
    'genpept' => 'AAC06201',
);

foreach my $db (keys %db2id) {
    subtest $db => sub {
        plan tests => 2;
        test_needs 'Data::Stag' if $db eq 'swissprot';
        my $seqid = $db2id{$db};
        my $seq;
        SKIP: {
           eval {
               $seq = get_sequence($db, $seqid);
           };
           skip "failed connection to $db: $@", 2 if $@;
           ok $seq;
           isa_ok $seq, 'Bio::SeqI';
        }
    }
}

done_testing();
