# Webserver logs parser

Returns in descending order list of webpages:
1. With most page views
2. With most unique page views

## Setup

Clone repository:

```
git clone <repo>
cd log_parser
```

Check if correct ruby version is installed:
```
cat .tool_versions
ruby -v
```

Install gems:
```
bundle install
```

## Usage

```
bin/parser webserver.log
```

## Specs

```
bundle exec rspec
```

### Example output

```
Total visits:
/about/2 90 views.
/contact 89 views.
/index 82 views.
/about 81 views.
/help_page/1 80 views.
/home 78 views.

Unique visits:
/help_page/1 23 unique views.
/contact 23 unique views.
/home 23 unique views.
/index 23 unique views.
/about/2 22 unique views.
/about 21 unique views.
