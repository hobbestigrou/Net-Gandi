use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Net::Gandi',
    AUTHOR        => q{Natal Ngétal <hobbestig@cpan.org>},
    VERSION_FROM  => 'lib/Net/Gandi.pm',
    ABSTRACT_FROM => 'lib/Net/Gandi.pm',
    PREREQ_PM => {
        'Test::More'   => 0,
        'Moose'        => 0,
        'XMLRPC::Lite' => 0,
        'Class::Date'  => 0,
    },
);
