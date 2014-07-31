default[:distelli][:agent][:user]             = 'distelli'
default[:distelli][:agent][:group]            = 'distelli'

default[:distelli][:agent][:version]          = '1.82'
default[:distelli][:agent][:url]              = 'http://download.distelli.com/'
default[:distelli][:agent][:package]          = "DistelliAgent-#{default[:distelli][:agent][:version]}.tar.gz"

# Required
default[:distelli][:agent][:access_token]     = ''
default[:distelli][:agent][:secret_key]       = ''

# Optional
default[:distelli][:agent][:s3_bucket_name]   = ''
default[:distelli][:agent][:s3_access_key_id] = ''
default[:distelli][:agent][:s3_secret_key]    = ''
default[:distelli][:agent][:server_id]        = ''

