#
#  Task::BeLike::HMA - Makefile.PL
#
#  Copyright (c) 2010-2011 Henning Manske. All rights reserved.
#
#  This program is free software. You can redistribute it and/or modify it
#  under the terms of either: the GNU General Public License as published
#  by the Free Software Foundation; or the Artistic License.
#
#  See http://dev.perl.org/licenses/
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

use 5.006001;

use strict;
use warnings;

BEGIN {
  # hack: load Module::CPANTS::Analyse before AutoInstall is loaded
  # TODO: bug report
  eval { require Module::CPANTS::Analyse };

  # Test::Tester warns on load if not loaded before Test::Builder
  eval { require Test::Tester };

  # prevent Carp::Always from installing its signal handlers
  eval { require Carp::Always };

  # force Module::AutoInstall to use CPAN.pm
  $ENV{PERL_AUTOINSTALL_PREFER_CPAN} = 1;
}

use inc::Module::Install;

# hack: install Module::Install from a Module::Install based Makefile.PL
# also, $VERSION of bundled inc/Module/Install.pm must be hacked to a lower
# version than required from the 'requires' command

use Module::AutoInstall;
shift @INC;



#
#  preliminary special setup for this Task
#

# check for recent versions of toolchain modules

unless ($ENV{PERL5_CPAN_IS_RUNNING}) {
  require CPAN;
  delete $ENV{PERL5_CPAN_IS_RUNNING};
  delete $ENV{PERL5_CPANPLUS_IS_RUNNING};
}

my $cpan   = eval { CPAN->VERSION } || 0;
my $mb     = eval { require Module::Build; Module::Build->VERSION } || 0;
my $lwp    = eval { require LWP; LWP->VERSION } || 0;
my $sqlite = eval { require CPAN::Config; $CPAN::Config->{use_sqlite} };
my $tymv   = eval { require Test::YAML::Meta::Version };

my $WANT_CPAN = '1.9301'; # version in Perl 5.8.9 core
my $WANT_MB   = '0.3603'; # 5.12.0

my $task = 'Task::BeLike::HMA::Toolchain 0.07_02';
my $url  = 'https://github.com/hma/Task-BeLike-HMA-Toolchain';

if (eval $cpan < $WANT_CPAN || eval $mb < $WANT_MB) {
  print "*** Toolchain too old.\n"
    . "    Consider installing $task first.\n"
    . "    See: $url\n";
  exit;
}

# suggest installation of Toolchain task

eval "use $task";
if ($@) {
  no warnings 'once';
  *MY::postamble = sub {
    print "\n*** Consider installing $task as well.\n"
      . "    See: $url\n\n";
    return "all ::\n"
      . "\t\$(NOECHO) \$(ECHO)\n"
      . "\t\$(NOECHO) \$(ECHO) \"*** Consider installing $task as well.\"\n"
      . "\t\$(NOECHO) \$(ECHO) \"    See: $url\"\n"
      . "\t\$(NOECHO) \$(ECHO)\n";
  }
}



#
#  module metadata
#

my $NAME = 'Task::BeLike::HMA';

(my $dist = $NAME) =~ s|::|-|g;
(my $path = $NAME) =~ s|::|/|g;

name       $dist;
license    'perl';
all_from   "lib/$path.pm";

bugtracker "https://github.com/hma/$dist/issues";
repository "https://github.com/hma/$dist";

#
#  notes
#
#  * autodie 2.10 t/caller.t fails if Perl < 5.8.4
#  * Module::Version requires autodie
#  * Perl::Critic 1.109 fails with '":color_severity" is not exported by
#    the Perl::Critic::Utils::Constants module' if Perl < 5.8.4
#  * Perl::MinimumVersion requires Perl::Critic
#  * Test::MinimumVersion requires Perl::MinimumVersion
#  * Test::CheckChanges 0.14 causes
#      1..1
#      # No tests run!
#    further on "make"
#      make: *** [installdeps] Error 255
#    TODO: bug report
#  * Module::Version 0.12 t/app.t fails if Getopt::Long < 2.36
#    TODO: bug report
#  * Test::Memory::Cycle 1.04 has unneccessary dependency PadWalker
#    TODO: bug report
#  * Data::Dump 1.18+ t/quote.t fails on 5.6.2, 5.8.0
#

requires 'Task::BeLike::HMA::Toolchain' => '0.07_02';

# Perl 5.10+ core pragmas

requires 'autodie'                      => '2.10'   if $] >= 5.008_004; # 5.13.3
requires 'parent'                       => '0.221'; # 5.10.1

# SSL support for LWP

if ($lwp < 6) {
  requires 'Crypt::SSLeay'              => '0.58';
}
else {
  requires 'LWP::Protocol::https'       => '6.02';
}

# common

requires 'Clone'                        => '0.30';
requires 'List::Util'                   => '1.23';  # 5.13.1
requires 'List::MoreUtils'              => '0.32';
requires 'Module::Pluggable'            => '3.9';   # 5.10.1
requires 'Readonly'                     => '1.03';
requires 'Readonly::XS'                 => '1.05'   if $] >= 5.008;
requires 'Task::Weaken'                 => '1.02';

# personal favourites

requires 'Exception::Class'             => '1.26'   if $] >= 5.008_001;
requires 'Package::Generator'           => '0.102'  if $] >= 5.008;
requires 'Sub::Exporter'                => '0.981';
requires 'Try::Tiny'                    => '0.07';

# testing

requires 'Test::Tester'                 => '0.107';
requires 'Test::NoWarnings'             => '1.02';
requires 'Test::Deep'                   => '0.108';
requires 'Test::Output'                 => '1.01';
requires 'Test::Exception'              => '0.31';
requires 'Test::Memory::Cycle'          => '1.04'   if $] >= 5.008_002;
requires 'Test::Requires'               => '0.04';
requires 'Test::Script'                 => '1.07'   if $] >= 5.008;
requires 'Test::Warn'                   => '0.23';

# personal favourites

requires 'aliased'                      => '0.30';
requires 'Carp::Always'                 => '0.06';
requires 'Carp::Clan'                   => '6.02';
requires 'Config::General'              => '2.50';
requires 'Data::Dump'                   => $] >= 5.008_001 ? '1.19' : '1.17';
requires 'Data::Hexify'                 => '1.00';
requires 'Data::Record';
requires 'File::Next'                   => '1.06';
requires 'JSON::XS'                     => '2.3'    if $] >= 5.008_002;
requires 'JSON'                         => '2.52';
requires 'Parse::RecDescent'            => '1.964';
requires 'Path::Class'                  => '0.24';
requires 'Text::CSV_XS'                 => '0.81';

# author / release testing

if ($] >= 5.008_001) {
  requires 'Pod::Simple'                => '3.16';  # 5.13.11
  requires 'Test::Pod'                  => '1.42';
  requires 'Test::Pod::No404s'          => '0.01';
}

requires 'Pod::Coverage'                => '0.19';
requires 'Test::Pod::Coverage'          => '1.08';
requires 'Test::CheckChanges'           => '0.14';
requires 'Test::CPAN::Meta'             => '0.17';
requires 'Test::DistManifest'           => '1.009';
requires 'Test::EOL'                    => '0.9'    if $] >= 5.008;
requires 'Test::HasVersion'             => '0.012';

if ($] >= 5.008_002 && ! $sqlite || $tymv) {
  #
  # CPAN::SQlite indexes only the latest release of a distribution (RT #63732)
  # Module::CPANTS::Analyse requires Test::YAML::Meta::Version
  # which is no longer contained in recent Test-YAML-Meta (RT #65903)
  # so if CPAN::SQlite is enabled and T::Y::M::Version is not installed
  # manual installation of T::Y::M::Version is required to enable
  # installation of Module::CPANTS::Analyse and Test::Kwalitee
  #
  # Test::YAML::Meta::Version is contained in
  # http://search.cpan.org/CPAN/authors/id/B/BA/BARBIE/Test-YAML-Meta-0.16.tar.gz
  #
  requires 'Module::CPANTS::Analyse'    => '0.85';
  requires 'Test::Kwalitee'             => '1.01';
}

if ($] >= 5.008_004) {
  my $perl_critic = eval {
    require List::MoreUtils;
    eval List::MoreUtils->VERSION <= 0.2703
  } ? '1.109' : '1.111';

  requires 'Perl::Critic'               => $perl_critic;
  requires 'Perl::MinimumVersion'       => '1.28';
  requires 'Test::MinimumVersion'       => '0.101080';
}

requires 'Test::Module::Used'           => '0.1.9'  if $] >= 5.008_003;
requires 'Test::NoTabs'                 => '1.0';
requires 'Test::Portability::Files'     => '0.05';
requires 'Test::Spelling'               => '0.14';
requires 'Devel::Cover'                 => '0.77';
requires 'Test::Strict'                 => '0.14'   if $] >= 5.008;
requires 'Test::Synopsis'               => '0.05'   if $] >= 5.008_001;

# admin

requires 'Getopt::Long'                 => '2.36';  # 5.9.5
requires 'Module::Version'              => '0.10'   if $] >= 5.008_004;
requires 'Module::Install'              => '1.01';
requires 'App::moduleshere'             => '0.07';
requires 'App::cpanminus'               => '1.4008' if $] >= 5.008;

if ($] >= 5.008_001) {
  requires 'local::lib'                 => '1.008002';
  requires 'App::cpanlistchanges'       => '0.05';
  requires 'App::cpanoutdated'          => '0.18';
  requires 'App::pmuninstall'           => '0.18';
}

if (index( $^X, 'perlbrew' ) == -1) {
  requires 'App::perlbrew'              => '0.27'   if $] >= 5.008;
  requires 'CPAN::Mini'                 => '1.111006';
}


build_requires 'Test::More';

clean_files "$dist-* Debian_CPANTS.txt";
makemaker_args dist => { COMPRESS => 'gzip -9f' };

auto_install;

WriteAll;
