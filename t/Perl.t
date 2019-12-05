#!/usr/bin/env perl
use utf8;

use strict;
use warnings;

use File::Spec;
use File::Temp;
use Test::More;

use Bio::Perl;

sub test_input_file {
    return File::Spec->catfile('t', 'data', @_);
}


my ($seq_object,$filename,$blast_report,@seq_object_array);

# will guess file format from extension
$filename = test_input_file('cysprot1.fa');
ok ($seq_object = read_sequence($filename));
isa_ok $seq_object, 'Bio::SeqI';

# forces genbank format
$filename = test_input_file('AF165282.gb');
ok  ($seq_object = read_sequence($filename,'genbank'));
isa_ok $seq_object, 'Bio::SeqI';

# reads an array of sequences
$filename = test_input_file('amino.fa');
is (@seq_object_array = read_all_sequences($filename,'fasta'), 2);
isa_ok $seq_object_array[0], 'Bio::SeqI';
isa_ok $seq_object_array[1], 'Bio::SeqI';

$filename = File::Temp->new();
ok write_sequence(">$filename",'genbank',$seq_object);
ok ($seq_object = new_sequence("ATTGGTTTGGGGACCCAATTTGTGTGTTATATGTA","myname","AL12232"));
isa_ok $seq_object, 'Bio::SeqI';

my $trans;

ok ($trans = translate($seq_object));

isa_ok $trans, 'Bio::SeqI';

ok ($trans = translate("ATTGGTTTGGGGACCCAATTTGTGTGTTATATGTA"));

isa_ok $trans, 'Bio::PrimarySeqI';

ok ($trans = translate_as_string($seq_object));

is $trans, 'IGLGTQFVCYM';

$trans = '';

ok ($trans = translate_as_string("ATTGGTTTGGGGACCCAATTTGTGTGTTATATGTA"));

is $trans, 'IGLGTQFVCYM';

done_testing();
