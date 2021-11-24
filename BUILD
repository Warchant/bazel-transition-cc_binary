load("//:variant.bzl", "build_variant", "string_flag")

string_flag(
    name = "variant",
    values = ["1", "2"],
    build_setting_default = "1"
)
config_setting(
    name = "variant_1",
    flag_values = {"variant": "1"},
    visibility = ["//visibility:public"],
)
config_setting(
    name = "variant_2",
    flag_values = {"variant": "2"},
    visibility = ["//visibility:public"],
)


cc_binary(
    name = 'main',
    srcs = ['main.c'],
    deps = [
        '//1_same_file:swc',
        '//2_diff_files:swc',
        '//3_diff_dirs:swc',
    ]
)

build_variant(
    name = "v1",
    binary = ":main",
    variant = "1"
)
build_variant(
    name = "v2",
    binary = ":main",
    variant = "2"
)
