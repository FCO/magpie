package redirect::handler;
use SAWA::Machine;
use mod_perl;
use constant MP2 => $mod_perl::VERSION >= 1.99;
BEGIN {
        if (MP2) {
                require Apache::Response;
                require Apache::Const;
        } else {
                require Apache::Constants;
        }
}

sub handler {
    my $r = shift;
    my $app = SAWA::Machine->new();
    $app->pipeline( qw(
        redirect::StepOne
        redirect::StepTwo
        basic::Output
    ) );
    $app->run({});
    return MP2 ? Apache::OK : Apache::Constants::OK;
}

1;