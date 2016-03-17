package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD

# TODO(jart): Remove this superfluous build rule when fix is released.
#             https://github.com/bazelbuild/bazel/issues/984
genrule(
    name = "phantomjs_bin",
    srcs = ["@phantomjs//file"],
    outs = ["phantomjs"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d tmp.XXXXXXXXXX)",
        "cd $$TMP",
        "tar -xjf $$IN",
        "cd phantomjs-*",
        "mv bin/phantomjs $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
)
