use strict;
use warnings;
use Test::More;

BEGIN {
    eval { require KiokuX::Model; };
    if ( $@ ) {
        plan skip_all => 'KiokuX::Model is not installed, cannot continue.'
    }
};

use FindBin;
use lib "$FindBin::Bin/lib";
use Plack::Test;
use Plack::Builder;
use Plack::Middleware::Magpie;
use HTTP::Request::Common;
use Bread::Board;

my $style_path = 't/htdocs/stylesheets';

my $handler = builder {
    enable "Magpie", pipeline => [ machine {
        match qr|/orders/| => [
            'Magpie::Resource::Kioku' => { dsn => "dbi:SQLite:dbname=temp/kiokutest.db" },
        ];
    }];
};

use Data::Dumper::Concise;

test_psgi
    app    => $handler,
    client => sub {
        my $cb = shift;
        {
            my $res = $cb->(GET "http://localhost/orders/655321");
            warn Dumper( $res );
#             like $res->content, qr/Hello Shopper!/;
#             like $res->content, qr/wooo/;
#             like $res->content, qr/Header/;
#             like $res->content, qr/Footer/;
        }
    };

ok(1);
done_testing;