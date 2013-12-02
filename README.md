DistelliAgentCookbook
=====================

This chef cookbook installs the Distelli Agent on a server. 

Usage
-----

To use this cookbook, update the distelli.yml file in files/default/ with your Distelli Access Token and Distelli Secret key found in your Distelli Account. Additionally you can specify an S3 Bucket and S3 access credentials if you wish to store deployable bundles in S3.

Once you've updated the distelli.yml file hust include `DistelliAgentCookbook` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[DistelliAgentCookbook]"
  ]
}
```

