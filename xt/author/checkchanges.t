#!perl -T
#
#  xt/author/checkchanges.t 0.01 hma Sep 16, 2010
#  Task-BeLike-HMA customized version 0.01 hma Sep 17, 2010
#  this version does not update Makefile
#
#  Check that the Changes file matches the distribution
#  RELEASE_TESTING only
#

use strict;
use warnings;

#  adopted Best Practice for Author Tests, as proposed by Adam Kennedy
#  http://use.perl.org/~Alias/journal/38822

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan( skip_all => 'Author tests not required for installation' );
  }
}

my %MODULES = (
  'Test::CheckChanges' => '0.14',
);

while (my ($module, $version) = each %MODULES) {
  $module .= ' ' . $version if $version;
  eval "use $module";
  die "Could not load required release testing module $module:\n$@" if $@;
}

# note: 'base' parameter is an undocumented feature of Test::CheckChanges
# required if this file resides one level deeper, e.g. in 'xt/author'

ok_changes( base => '..' );
