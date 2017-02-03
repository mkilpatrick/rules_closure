# Copyright 2017 The Closure Rules Authors. All rights reserved.
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

def _filegroup_external(ctx):
  """Downloads files into filegroup rule.

  This rule is capable of either downloading files individually, or downloading
  tarballs which are extracted. It's also capable of downloading different URLs
  for different platforms.
  """
  strip_prefix = ctx.attr.strip_prefix
  downloaded = set()
  basenames = set()
  data = set(ctx.attr.data)
  srcs = set()
  for sha256, urls, extract in _get_downloads(ctx):
    basename = ""
    for url in urls:
      basename = url[url.rindex("/") + 1:] or basename
      if url in downloaded:
        fail("url specified multiple times: " + url)
      downloaded += [url]
    basename = _get_match(ctx.attr.rename, urls) or basename
    if basename in basenames:
      fail("filegroup path collision: " + basename)
    basenames += [basename]
    if extract:
      srcs = None
      ctx.download_and_extract(
          urls, "", sha256, "", _get_match(ctx.attr.strip_prefix, urls))
    else:
      if srcs != None:
        srcs += [basename]
      ctx.download(
          urls, basename, sha256, _has_match(ctx.attr.executable, urls))
  lines = ["# DO NOT EDIT: generated by filegroup_external()", ""]
  if ctx.attr.default_visibility:
    lines.append("package(default_visibility = %s)" % (
        _repr_list(ctx.attr.default_visibility, indent="")))
    lines.append("")
  lines.append("licenses(%s)" % _repr_list(ctx.attr.licenses, indent=""))
  lines.append("")
  lines.append("filegroup(")
  lines.append("    name = %s," % repr(
      ctx.attr.generated_rule_name or ctx.name))
  if ctx.attr.testonly_:
    lines.append("    testonly = 1,")
  if srcs == None:
    lines.append("    srcs = glob([\"**\"]),")
  else:
    lines.append("    srcs = %s," % _repr_list(srcs))
  if data:
    lines.append("    data = %s," % _repr_list(data))
  if ctx.attr.path:
    lines.append("    path = %s," % repr(ctx.attr.path))
  if ctx.attr.visibility:
    lines.append("    visibility = %s," %
                 _repr_list(ctx.attr.visibility))
  lines.append(")")
  lines.append("")
  extra = ctx.attr.extra_build_file_content
  if extra:
    lines.append(extra)
    if not extra.endswith("\n"):
      lines.append("")
  ctx.file("BUILD", "\n".join(lines))

def _get_downloads(ctx):
  os_name = ctx.os.name.lower()
  if (os_name.startswith("mac os") and
      (ctx.attr.sha256_urls_macos or
       ctx.attr.sha256_urls_extract_macos)):
    return _merge(
        ctx.attr.sha256_urls_macos,
        ctx.attr.sha256_urls_extract_macos)
  elif (os_name.find("windows") != -1 and
      (ctx.attr.sha256_urls_windows or
       ctx.attr.sha256_urls_extract_windows)):
    return _merge(
        ctx.attr.sha256_urls_windows,
        ctx.attr.sha256_urls_extract_windows)
  elif (ctx.attr.sha256_urls or
        ctx.attr.sha256_urls_extract):
    return _merge(
        ctx.attr.sha256_urls,
        ctx.attr.sha256_urls_extract)
  else:
    fail("No URLs are available for downloading %s" % ctx.name)

def _merge(file_urls, archive_urls):
  result = []
  for dict_list, extract in ((file_urls, False),
                             (archive_urls, True)):
    for sha256, urls in dict_list.items():
      result.append((sha256, urls, extract))
  return result

def _has_match(string_list, urls):
  for url in urls:
    if url in string_list or url[url.rindex("/") + 1:] in string_list:
      return True
  return False

def _get_match(string_dict, urls):
  for url in urls:
    result = string_dict.get(url[url.rindex("/") + 1:], None)
    if result:
      return result
    result = string_dict.get(url, None)
    if result:
      return result
  return ""

def _repr_list(items, indent="    "):
  items = sorted(items)
  if not items:
    return "[]"
  if len(items) == 1:
    return repr(items)
  parts = [repr(item) for item in items]
  return (("[\n%s    " % indent) +
          (",\n%s    " % indent).join(parts) +
          (",\n%s]" % indent))

filegroup_external = repository_rule(
    implementation=_filegroup_external,
    attrs={
        "sha256_urls": attr.string_list_dict(),
        "sha256_urls_macos": attr.string_list_dict(),
        "sha256_urls_windows": attr.string_list_dict(),
        "sha256_urls_extract": attr.string_list_dict(),
        "sha256_urls_extract_macos": attr.string_list_dict(),
        "sha256_urls_extract_windows": attr.string_list_dict(),
        "strip_prefix": attr.string_dict(),
        "rename": attr.string_dict(),
        "executable": attr.string_list(),
        "licenses": attr.string_list(mandatory=True, allow_empty=False),
        "data": attr.string_list(),
        "path": attr.string(),
        "testonly_": attr.bool(),
        "generated_rule_name": attr.string(),
        "default_visibility": attr.string_list(default=["//visibility:public"]),
        "extra_build_file_content": attr.string(),
    })
