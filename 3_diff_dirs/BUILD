cc_library(
    name = "swc",
    deps = [
        '//3_diff_dirs/common:common'
    ] + select({
        '//:variant_1': ['//3_diff_dirs/v1:swc'],
        '//:variant_2': ['//3_diff_dirs/v2:swc'],
    }, no_match_error = "Neither v1 nor v2"),
    visibility = ["//visibility:public"],
)