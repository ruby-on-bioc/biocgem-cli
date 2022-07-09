# frozen_string_literal: true

module BiocGem
  Options = Struct.new(
    :output_directory,
    :bioc_package_name,
    :bioc_sqlite_database_name,
    :gem_icon,
    :gem_constant_name,
    :gem_require_name,
    :bioc_package_md5sum,
    :bioc_package_sha256sum,
    :bioc_version,
    :bioc_package_version
  )
end
