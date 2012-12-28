package Net::Gandi::Error;

# ABSTRACT: Internal class to manage error.

use Moose ();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    as_is     => ['_validated_params'],
    also      => 'Moose',
);

use Params::Check qw( check );

use Const::Fast;
use Data::Dumper;

const my %TEMPLATE_VALIDATED => (
    vm_create => {
        datacenter_id => {
            required => 1,
            defined  => 1
            #allow    => qr/^\d+$/,
        },
        ip_version => {
            required => 1,
            defined  => 1
        },
        sys_disk_id => {
            required => 1,
            defined  => 1
        },
        memory => {
            required => 1,
            defined  => 1
        },
        hostname => {
            required => 1,
            defined  => 1
        }
    },
    vm_create_from => {
        datacenter_id => {
            required => 1,
            defined  => 1
            #allow    => qr/^\d+$/,
        },
        ip_version => {
            required => 1,
            defined  => 1
        },
        memory => {
            required => 1,
            defined  => 1
        },
        hostname => {
            required => 1,
            defined  => 1
        }
    },
    disk_create => {
        datacenter_id => {
            required => 1,
            defined  => 1
        },
        name => {
            required => 1,
            defined  => 1
        },
        size => {
            required => 1,
            defined  => 1
        },
    },
    disk_create_from => {
        name => {
            required => 1,
            defined  => 1
        },
    },
    iface_create => {
        datacenter_id => {
            required => 1,
            defined  => 1
        },
        ip_version => {
            required => 1,
            defined  => 1
        },
    },
    iface_update => {
        bandwith => {
            required => 1,
            defined  => 1
        },
    },
    ip_create => {
        datacenter_id => {
            required => 1,
            defined  => 1
            #allow    => qr/^\d+$/,
        },
        ip_version => {
            required => 1,
            defined  => 1
        }
    },
    ip_update => {
        reverse => {
            required => 1,
            defined  => 1
        }
    },
);

sub _validated_params {
    my ( $type, $args ) = @_;

    check($TEMPLATE_VALIDATED{$type}, $args, 1) or croak 'Invalid hash';
}

1;
