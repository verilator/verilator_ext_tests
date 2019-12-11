#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2019 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(dist => 1);

sub check {
    my ($a, $b, $basename) = @_;
    my $cmd = "diff -u $a/$basename $b/$basename 2>&1";
    print "\t$cmd\n" if $Self->{verbose};
    my $out = `$cmd`;
    if ($? || $o) {
        print $out;
        $Self->error("Differences in $basename");
        $Self->copy_if_golden("$a/$basename", "$b/$basename");
    }
}

print `pwd`;
my $g = "submodules/gtkwave/gtkwave3-gtk3";
my $v = $ENV{VERILATOR_ROOT} || "submodules/verilator";

check("$g/src", "$v/include/gtkwave", "wavealloca.h");
check("$g/src/helpers/fst", "$v/include/gtkwave", "fastlz.h");
check("$g/src/helpers/fst", "$v/include/gtkwave", "fastlz.c");
check("$g/src/helpers/fst", "$v/include/gtkwave", "fstapi.h");
check("$g/src/helpers/fst", "$v/include/gtkwave", "fstapi.c");
check("$g/src/helpers/fst", "$v/include/gtkwave", "lz4.h");
check("$g/src/helpers/fst", "$v/include/gtkwave", "lz4.c");

ok(1);
1;
