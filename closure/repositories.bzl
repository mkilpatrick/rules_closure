# -*- mode: python; -*-
#
# Copyright 2016 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""External dependencies for Closure Rules."""

def closure_repositories():

  native.maven_jar(
      name = "aopalliance",
      artifact = "aopalliance:aopalliance:1.0",
      sha1 = "0235ba8b489512805ac13a8f9ea77a1ca5ebe3e8",
  )

  native.maven_jar(
      name = "asm",
      artifact = "org.ow2.asm:asm:5.0.3",
      sha1 = "dcc2193db20e19e1feca8b1240dbbc4e190824fa",
  )

  native.maven_jar(
      name = "asm_analysis",
      artifact = "org.ow2.asm:asm-analysis:5.0.3",
      sha1 = "c7126aded0e8e13fed5f913559a0dd7b770a10f3",
  )

  native.maven_jar(
      name = "asm_commons",
      artifact = "org.ow2.asm:asm-commons:5.0.3",
      sha1 = "a7111830132c7f87d08fe48cb0ca07630f8cb91c",
  )

  native.maven_jar(
      name = "asm_util",
      artifact = "org.ow2.asm:asm-util:5.0.3",
      sha1 = "1512e5571325854b05fb1efce1db75fcced54389",
  )

  native.maven_jar(
      name = "args4j",
      artifact = "args4j:args4j:2.0.26",
      sha1 = "01ebb18ebb3b379a74207d5af4ea7c8338ebd78b",
  )

  native.maven_jar(
      name = "closure_compiler",
      artifact = "com.google.javascript:closure-compiler:v20160208",
      sha1 = "5a2f4be6cf41e27ed7119d26cb8f106300d87d91",
  )

  native.new_http_archive(
      name = "closure_library",
      url = "https://github.com/google/closure-library/archive/20160208.zip",
      sha256 = "8f610300e4930190137505a574a54d12346426f2a7b4f179026e41674e452a86",
      strip_prefix = "closure-library-20160208",
      build_file = "closure/library/closure_library.BUILD",
  )

  native.new_http_archive(
      name = "closure_linter",
      url = "https://github.com/google/closure-linter/archive/v2.3.19.zip",
      sha256 = "ccb93b7327cd1e1520d0090c51f2f11d5174a34df24e1fa4d0114ffff28a7141",
      strip_prefix = "closure-linter-2.3.19",
      build_file = "closure/linter/closure_linter.BUILD",
  )

  native.maven_jar(
      name = "closure_stylesheets",
      artifact = "com.google.closure-stylesheets:closure-stylesheets:20160212",
      sha1 = "f0e8625a2cfe0f501b28f5e6438b836358da8a97",
  )

  native.maven_jar(
      name = "icu4j",
      artifact = "com.ibm.icu:icu4j:56.1",
      sha1 = "8dd6671f52165a0419e6de5e1016400875a90fa9",
  )

  native.maven_jar(
      name = "guice",
      artifact = "com.google.inject:guice:3.0",
      sha1 = "9d84f15fe35e2c716a02979fb62f50a29f38aefa",
  )

  native.maven_jar(
      name = "guice_assistedinject",
      artifact = "com.google.inject.extensions:guice-assistedinject:3.0",
      sha1 = "544449ddb19f088dcde44f055d30a08835a954a7",
  )

  native.maven_jar(
      name = "guice_multibindings",
      artifact = "com.google.inject.extensions:guice-multibindings:3.0",
      sha1 = "5e670615a927571234df68a8b1fe1a16272be555",
  )

  # XXX: new_http_archive() doesn't maintain the executable bit.
  #      https://github.com/bazelbuild/bazel/issues/984
  native.http_file(
      name = "phantomjs",
      sha256 = "86dd9a4bf4aee45f1a84c9f61cf1947c1d6dce9b9e8d2a907105da7852460d2f",
      url = "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2",
  )

  native.new_http_archive(
      name = "python_gflags",
      url = "https://github.com/google/python-gflags/archive/3.0.2.zip",
      sha256 = "8700f5b8d61f843425b090287874b4ff45510d858caa109847162dd98c7856f8",
      strip_prefix = "python-gflags-3.0.2",
      build_file = "closure/linter/python_gflags.BUILD",
  )

  native.maven_jar(
      name = "soy",
      artifact = "com.google.template:soy:2016-01-12",
      sha1 = "adadc37aecf1042de7c9c6a6eb8f34719500ed69",
  )

  native.http_file(
      name = "soyutils_usegoog",
      sha256 = "fdb0e318949c1af668038df1d85d45353a00ff585f321c86efe91ac2a10cc91f",
      url = "https://repo1.maven.org/maven2/com/google/template/soy/2016-01-12/soy-2016-01-12-soyutils_usegoog.js",
  )
