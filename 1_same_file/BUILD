cc_library(
    name = 'swc',
    srcs = ['ca.c'],
    defines = select({
        "//:variant_1": ['VARIANT=1'],
        "//:variant_2": ['VARIANT=2'],
    }),
    visibility = ["//visibility:public"],
)

