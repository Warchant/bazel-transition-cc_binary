
def _variant_transition_impl(settings, attr):
    _ignore = (settings, attr)

    if not hasattr(attr, 'variant'):
        fail("doesn't have variant attribute")

    return {
        "//:variant": attr.variant
    }

variant_transition = transition(
    implementation = _variant_transition_impl,
    inputs = [],
    outputs = ["//:variant"]
)

def _impl(ctx):
    outfile = ctx.actions.declare_file("{}.exe".format(ctx.label.name))
    cc_binary_outfile = ctx.files.binary[0]
    ctx.actions.run_shell(
        inputs = [cc_binary_outfile],
        outputs = [outfile],
        command = "cp {} {}".format(cc_binary_outfile.path, outfile.path),
    )
    return DefaultInfo(
        executable = outfile,
    )

build_variant = rule(
    implementation = _impl,
    attrs = {
        "binary": attr.label(cfg = variant_transition, mandatory=True),
        "variant": attr.string(values = ["1", "2"]),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    }
)
