# BiocGem

[![test](https://github.com/ruby-on-bioc/biocgem/actions/workflows/ci.yml/badge.svg)](https://github.com/ruby-on-bioc/biocgem/actions/workflows/ci.yml)

Extract the database included in the Bioconductor annotation package and use it in the Ruby gem.

## Installation

```sh
gem install biocgem
```

## Usage

### 1.Generate your gem

Short options

```
biocgem new \
  -n org.Hs.eg.db \
  -s org.Hs.eg.sqlite \
  -v 3.14.0
```

Full options

```sh
biocgem new --bioc_package_name org.Mm.eg.db \
            --bioc_sqlite_database_name org.Mm.eg.sqlite \
            --gem_icon :mouse: \
            --gem_constant_name OrgMmEgDb \
            --gem_require_name org_mm_eg_db \
            --bioc_package_sha256sum 56f228448b50f1cea0fc15d6f61b1e94359ef885336034bf346693315390ad45 \
            --bioc_version 3.14 \
            --bioc_package_version 3.14.0
```

### 2. Install your gem

```
cd org.Hs.eg.db
rake extdata:download
# rake test
rake install
```

## Development

With all due respect to the R language and Bioconductor maintainers...

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby-on-bioc/biocgem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
