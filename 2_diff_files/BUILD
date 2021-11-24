cc_library(
    name = 'swc',
    srcs = [
        'common.c'
    ] + select({
        "//:variant_1": ['v1.c'],
        "//:variant_2": ['v2.c'],
    }),
    visibility = ["//visibility:public"],
)