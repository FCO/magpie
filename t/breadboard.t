use Test::More;
use FindBin;
use lib "$FindBin::Bin/lib";
use Data::Dumper::Concise;
use Bread::Board;
use Bread::Board::Dumper;

use_ok('Magpie::Machine');

my $resources = container 'Wibble' => as {
        service 'somevar' => 'some value';
};

my $m = Magpie::Machine->new();

$m->breadboard->assets( $resources );

ok( $m );

$m->breadboard->assets->add_service( service 'othervar' => 'other value' );

warn "\n" . Bread::Board::Dumper->new->dump( $m->breadboard );

$m->pipeline(qw( Magpie::Pipeline::Breadboard::Simple ));

$m->run( {} );

done_testing();