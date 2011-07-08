package Core::HTTP::Base;
use Moose;
use Magpie::Constants;
extends 'Magpie::Component';

__PACKAGE__->register_events(qw(init cookie headers multicookie redirect redirect_cookie));

sub load_queue {
    my ($self, $ctxt) = @_;
    my @events = ('init');
    if ( my $event = $self->request->param('appstate') ) {
        push @events, $event;
    }
    return @events;
}

sub init {
    my $self    = shift;
    my $ctxt    = shift;
    $ctxt->{content} = '<p>Howdy</p>';
    return OK;
}

sub cookie {
    my $self = shift;
    my $ctxt = shift;
    $self->response->cookies->{name} = 'value';
    return OK;
}

sub multicookie {
    my $self = shift;
    my $ctxt = shift;
    $self->response->cookies->{name1} = 'oreo';
    $self->response->cookies->{name2} = 'peanutbutter';
    return OK;
}

sub headers {
    my $self = shift;
    my $ctxt = shift;
    $self->response->content_type('text/xml');
    $self->response->content_encoding('UTF-8');
    $self->response->header( 'X-Wibble' => 'text/x-ubu' );
    $self->response->header( Bogus => 'arbitrary' );
    return OK;
}

sub redirect {
    my $self = shift;
    my $ctxt = shift;
    $self->response->redirect('/imnotthere');
    return OK;
}

sub redirect_cookie {
    my $self = shift;
    my $ctxt = shift;
    $self->response->cookies->{name} = 'val';
    $self->response->redirect('/imnotthere');
    return OK;
}


1;
