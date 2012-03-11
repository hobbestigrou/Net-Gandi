package Net::Gandi::Role::XMLRPC;

use XMLRPC::Lite;
use Data::Dumper;
use Moose::Role;
use MooseX::Types::Moose 'Str';

sub call_rpc {
    my ( $self, $method, @args ) = @_;

    my $url          = $self->apiurl;
    my $proxy        = XMLRPC::Lite->proxy($url);
    my $api_response = $proxy->call($method, $self->apikey, @args);
    $proxy->transport->agent($self->useragent);

    if ( $api_response->faultstring() ) {
        $self->err($api_response->faultcode());
        $self->errstr($api_response->faultstring());
        return undef;
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
