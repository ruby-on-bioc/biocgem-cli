# biocgem command line tool

[![Gem Version](https://badge.fury.io/rb/biocgem.svg)](https://badge.fury.io/rb/biocgem)
[![test](https://github.com/ruby-on-bioc/biocgem/actions/workflows/ci.yml/badge.svg)](https://github.com/ruby-on-bioc/biocgem/actions/workflows/ci.yml)

biocgem is a command line tool for generating ruby gems.
biocgem extract the databases included in the [Bioconductor](https://bioconductor.org/) annotation [packages](https://bioconductor.org/packages/release/BiocViews.html#___AnnotationData). biocgem supports sqlite only. 

## Installation

```sh
gem install biocgem
```

## Usage

### 1.Generate your gem

```
biocgem new \
  -n org.Hs.eg.db \
  -s org.Hs.eg.sqlite \
  -v 3.14.0
```

When executed, a directory just like the repository in the following link will be created.
* https://github.com/ruby-on-bioc/org.Hs.eg.db

Full options

```sh
biocgem new \
  --bioc_package_name org.Mm.eg.db \
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

### 3. Usage

[Sequel](https://github.com/jeremyevans/sequel) is used to access Sqlite files from Ruby, see the org.Hs.eg.db example.

* https://github.com/ruby-on-bioc/org.Hs.eg.db

```ruby
require 'org_hs_eg_db'

DB = OrgHsEgDb

DB.class  # Sequel::SQLite::Database
DB.tables # List of tables

DB[:alias].first
 # => {:_id=>1, :alias_symbol=>"A1B"}

DB[:alias].take(10)
DB[:alias].where(alias_symbol: "HBA1").all
 # => [{:_id=>2473, :alias_symbol=>"HBA1"}]

DB[:alias].join(:gene_info, _id: :_id).where(alias_symbol: "HBA1").first
 # {:_id=>2473,
 # :alias_symbol=>"HBA1",
 # :gene_name=>"hemoglobin subunit alpha 1",
 # :symbol=>"HBA1"}

DB[:alias].join(:genes, _id: :_id).where(alias_symbol: "HBA1").all
 # => [{:_id=>2473, :alias_symbol=>"HBA1", :gene_id=>"3039"}]
```

```ruby
ensembl_ids = %w(ENSG00000150676 ENSG00000099308 ENSG00000142676
                 ENSG00000180776 ENSG00000108848 ENSG00000277370)
                   
DB[:ensembl].join(:genes, _id: :_id).where(ensembl_id: ensembl_ids).select_map(:gene_id)
# => 
# ["6135", "23031", "26800", "51747", "220047", "253832"]
```

### 4. Generate multiple gems

How to automatically generate multiple Ruby gems from a list of bioconductor package names?
* https://github.com/ruby-on-bioc/bioc-gems

## Development

1. Ruby on Bioc is a small project and focuses on sustainability rather than development.
2. Respect to the developers of R and Bioconductor. This project rides on the beautiful ecosystem of R, but that doesn't mean you should act like a free rider.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby-on-bioc/biocgem.

  Do you need commit rights to my repository?
  Do you want to get admin rights and take over the project?
  If so, please feel free to contact us.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
