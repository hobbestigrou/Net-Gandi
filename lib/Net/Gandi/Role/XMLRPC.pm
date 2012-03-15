package Net::Gandi::Role::XMLRPC;

# ABSTRACT: A Perl interface for gandi api

use XMLRPC::Lite;
use Moose::Role;
use MooseX::Types::Moose 'Str';
use Net::Gandi::Exception;

use Carp;

has '_proxy' => (
    is       => 'ro',
    isa      => 'XMLRPC::Lite',
    builder  => '_build_proxy',
    init_arg => undef,
    lazy     => 1,
);

sub _build_proxy {
    my ( $self ) = @_;

    my $proxy = XMLRPC::Lite->proxy($self->apiurl, timeout => $self->timeout );
    $proxy->transport->agent($self->useragent);

    $proxy;
}

sub call_rpc {
    my ( $self, $method, @args ) = @_;

    my $api_response = $self->_proxy->call($method, $self->apikey, @args);

    if ( $api_response->faultstring() ) {
        my $exception = Net::Gandi::Exception->new(
            err    => $api_response->faultcode(),
            errstr => $api_response->faultstring(),
        );
        croak 'Error: ' . $exception->err . ' ' . $exception->errstr;
    }

    #if ( $self->date_object ) {
    #    return _date_object($api_response->result());
    #}
    #else {
    #    return $api_response->result();
    #}

    return $api_response->result();
}

=head1 cast_value

Force XMLRPC data types, to use before calls when using booleans for example.

=cut

sub cast_value {
    my ( $self, $type, $value ) = @_;

    return XMLRPC::Data->type($type)->value($value);
}

1;
