package Net::Gandi::Exception;

use Moose;

has 'err' => (
    is      => 'rw',
    isa     => 'Int',
);

has 'errstr' => (
    is      => 'rw',
    isa     => 'Str',
);

1;
