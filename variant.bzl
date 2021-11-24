BuildSettingInfo = provider(
    doc = "A singleton provider that contains the raw value of a build setting",
    fields = {
        "value": "The value of the build setting in the current configuration. " +
                 "This value may come from the command line or an upstream transition, " +
                 "or else it will be the build setting's default.",
    },
)

def _string_impl(ctx):
    allowed_values = ctx.attr.values
    value = ctx.build_setting_value
    if len(allowed_values) == 0 or value in ctx.attr.values:
        return BuildSettingInfo(value = value)
    else:
        fail('''
        
        Error setting {}: invalid value '{}'. Allowed values are {}.

        '''.format(str(ctx.label), value, str(allowed_values)))


string_flag = rule(
    implementation = _string_impl,
    build_setting = config.string(flag = True),
    attrs = {
        "values": attr.string_list(
            doc = "The list of allowed values for this setting. An error is raised if any other value is given.",
        ),
    },
    doc = "A string-typed build setting that can be set on the command line",
)

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
    outputs = ctx.files.binary
    return DefaultInfo(
        files = depset(outputs),
        runfiles = ctx.runfiles(transitive_files = depset(outputs)),
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
